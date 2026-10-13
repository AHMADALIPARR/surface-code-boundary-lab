#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
Voyager Maze — arithmetic navigation over Spine 64 hex-cipher nodes.

Mock key unlocks the hidden platform. Mirror operator is an involution
on the state vector. Path cost uses a simple p-adic-style valuation
(trailing-zero count in the prime difference).
"""

from __future__ import annotations
from dataclasses import dataclass, field
from typing import Dict, List, Optional
import hashlib

# Mock key — replace in production
MOCK_KEY = "SNAPKITTY-VOYAGER-408-340-SPINE64"

# Spine 64 seed nodes (from hex cipher)
NODES: Dict[str, str] = {
    "zeta_node_00": "0x02.14AB",  # start
    "zeta_node_01": "0x03.21CD",  # distractor
    "zeta_node_02": "0x05.25EF",
    "zeta_node_0F": "0x35.67AB",  # hidden platform
    "zeta_node_63": "0xFB.FF00",  # terminal boundary
}

START = "zeta_node_00"
GOAL = "zeta_node_0F"

def key_ok(presented: str) -> bool:
    """Constant-time-ish compare against the mock key hash."""
    expect = hashlib.sha256(MOCK_KEY.encode()).hexdigest()
    got = hashlib.sha256(presented.encode()).hexdigest()
    return expect == got

def mirror_flip(state: List[complex]) -> List[complex]:
    """Involutive mirror: conjugate and reverse."""
    return [c.conjugate() for c in reversed(state)]

def padic_distance(a: str, b: str) -> int:
    """Crude valuation: trailing zero bits of the XOR of the integer fields."""
    def int_field(tok: str) -> int:
        return int(tok.split(".")[0], 16)
    x = int_field(NODES[a]) ^ int_field(NODES[b])
    if x == 0:
        return 99
    return (x & -x).bit_length() - 1

@dataclass
class MazeAgent:
    key: str
    position: str = START
    memory: List[str] = field(default_factory=list)
    unlocked: bool = False

    def __post_init__(self):
        self.unlocked = key_ok(self.key)
        self.memory.append(self.position)

    def step(self, target: str) -> str:
        if not self.unlocked:
            return "LOCKED"
        if target not in NODES:
            return "UNKNOWN_NODE"
        dist = padic_distance(self.position, target)
        self.position = target
        self.memory.append(target)
        if target == GOAL:
            return f"ESCAPE dist={dist}"
        return f"MOVE {target} dist={dist}"

    def traverse(self, path: Optional[List[str]] = None) -> List[str]:
        path = path or [START, "zeta_node_01", "zeta_node_02", GOAL]
        log = []
        for node in path:
            log.append(self.step(node))
            if self.position == GOAL:
                break
        return log


def demo() -> None:
    print("Voyager Maze — mock key demo")
    print(f"Nodes: {list(NODES)}")
    print(f"Start: {START}  Goal: {GOAL}")

    # Bad key
    bad = MazeAgent("wrong-key")
    print(f"Bad key unlocked={bad.unlocked} step={bad.step(GOAL)}")

    # Good key
    agent = MazeAgent(MOCK_KEY)
    print(f"Good key unlocked={agent.unlocked}")
    for line in agent.traverse():
        print(" ", line)
    print(f"Memory: {agent.memory}")

    # Mirror involution check
    st = [1+2j, 3+4j, 5+0j]
    assert mirror_flip(mirror_flip(st)) == st
    print("MirrorFlip involution: OK")


if __name__ == "__main__":
    demo()
