#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
Many-Worlds maze: unitary branching over Spine 64 nodes.
Each fork produces two phase-shifted children; dead branches prune.
"""

from __future__ import annotations
from dataclasses import dataclass, field
from typing import List, Optional
import cmath
import math

from voyager_maze import NODES, START, GOAL, padic_distance

@dataclass
class Branch:
    position: str
    amplitude: complex
    path: List[str] = field(default_factory=list)
    alive: bool = True

    def fork(self, prime_phase: float) -> tuple["Branch", "Branch"]:
        left = Branch(self.position, self.amplitude * cmath.exp(1j * prime_phase),
                      self.path + [self.position], True)
        right = Branch(self.position, self.amplitude * cmath.exp(-1j * prime_phase),
                       self.path + [self.position], True)
        return left, right

class ManyWorldsMaze:
    def __init__(self, max_branches: int = 64):
        self.branches: List[Branch] = [Branch(START, 1+0j, [START])]
        self.max_branches = max_branches

    def step_all(self) -> None:
        new: List[Branch] = []
        for b in self.branches:
            if not b.alive:
                continue
            # Phase from node index
            idx = int(b.position.split("_")[-1], 16) if "_" in b.position else 0
            phase = math.pi * idx / 64.0
            left, right = b.fork(phase)
            # Advance each child toward a neighbor or goal
            for child, prefer_goal in ((left, True), (right, False)):
                if prefer_goal and padic_distance(child.position, GOAL) < 8:
                    child.position = GOAL
                else:
                    # Wander to a distractor
                    child.position = "zeta_node_01" if child.position != "zeta_node_01" else "zeta_node_02"
                child.path.append(child.position)
                if child.position == GOAL:
                    child.alive = True  # success
                new.append(child)
        # Prune to capacity (keep highest |amplitude|)
        new.sort(key=lambda b: abs(b.amplitude), reverse=True)
        self.branches = new[:self.max_branches]

    def converged(self) -> bool:
        return any(b.position == GOAL and b.alive for b in self.branches)

    def run(self, max_steps: int = 16) -> List[Branch]:
        for _ in range(max_steps):
            if self.converged():
                break
            self.step_all()
        return [b for b in self.branches if b.position == GOAL]


def demo() -> None:
    mw = ManyWorldsMaze()
    winners = mw.run()
    print(f"Many-Worlds: {len(mw.branches)} live branches, {len(winners)} reached goal")
    if winners:
        print(f"  example path: {winners[0].path[:6]}...")


if __name__ == "__main__":
    demo()
