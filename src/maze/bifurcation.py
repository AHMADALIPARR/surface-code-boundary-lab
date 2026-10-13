#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
Agentic bifurcation and multiplicity chaos.

Multiplicity-weighted logistic map drives period-doubling.
Shadow-prime imaginary parts inject deterministic phase perturbations.
QSL bounds prune unstable branches.
"""

from __future__ import annotations
import math
from dataclasses import dataclass, field
from typing import List

from qsl import verify_speed_limit, qsl_time

# Feigenbaum accumulation point
FEIGENBAUM = 3.5699934

# Illustrative shadow ordinates (first few from the hex-cipher table)
SHADOW_GAMMA = [
    14.1347, 21.0220, 25.0108, 30.4248, 32.9351,
    37.5862, 40.9187, 43.3271, 48.0051, 49.7738,
]

@dataclass
class Agent:
    value: float          # logistic state in [0, 1]
    multiplicities: List[int]
    position: str = "zeta_node_00"
    alive: bool = True
    path: List[str] = field(default_factory=list)

    def sector_leakage(self) -> float:
        """Crude leakage: distance of value outside [0, 1]."""
        if 0.0 <= self.value <= 1.0:
            return 0.0
        return min(abs(self.value), abs(self.value - 1.0))


def compute_mu(multiplicities: List[int], gammas: List[float] = SHADOW_GAMMA) -> float:
    """μ = r_∞ + 1.5 / (1 + exp(-Σ e_k ln|γ_k|))."""
    weight = 0.0
    for e, g in zip(multiplicities, gammas):
        weight += e * math.log(abs(g) + 1e-9)
    return FEIGENBAUM + (1.5 / (1.0 + math.exp(-weight / 10.0)))


def inject_chaos(agent: Agent, step: int, scale: float = 0.05) -> float:
    """Sum sin(γ_k * step) / max(1, e_k), then logistic + mirror term."""
    pert = 0.0
    for e, g in zip(agent.multiplicities, SHADOW_GAMMA):
        pert += math.sin(g * step) / max(1, e)
    x = agent.value
    # Mirror term: (1-x) acts as the involution on [0,1]
    return x * (1.0 - x) + scale * pert * (1.0 - x)


def logistic_step(x: float, mu: float) -> float:
    return mu * x * (1.0 - x)


class BifurcationEngine:
    def __init__(self, n_agents: int = 8, seed_mult: int = 1):
        self.agents = [
            Agent(
                value=0.1 + 0.8 * i / n_agents,
                multiplicities=[seed_mult + (i % 3)] * len(SHADOW_GAMMA),
                path=["zeta_node_00"],
            )
            for i in range(n_agents)
        ]
        self.clock = 0
        self.fork_count = 0

    def step(self) -> None:
        self.clock += 1
        if not self.agents:
            return
        # Global mu from first agent's multiplicities
        mu = compute_mu(self.agents[0].multiplicities)
        new_agents: List[Agent] = []
        for a in self.agents:
            if not a.alive:
                continue
            # QSL gate (demo: elapsed exceeds tau)
            elapsed = 4.0
            delta_h = 0.5
            if not verify_speed_limit(elapsed, delta_h, delta_h):
                a.alive = False
                continue
            # Chaos injection then logistic
            chaotic = inject_chaos(a, self.clock)
            a.value = max(0.0, min(1.0, logistic_step(chaotic, mu / 4.0)))  # scale mu into logistic range
            # Bifurcation window (raw mu; fork every 5 steps in demo)
            if self.clock % 5 == 0:
                # Fork: clone with slight phase offset
                clone = Agent(
                    value=min(1.0, a.value + 0.01),
                    multiplicities=list(a.multiplicities),
                    position=a.position,
                    path=list(a.path),
                )
                new_agents.append(clone)
                self.fork_count += 1
            # Leakage prune
            if a.sector_leakage() > 0.5:
                a.alive = False
            else:
                # Advance toward goal symbolically
                if a.value > 0.3 or self.clock > 15:
                    a.position = "zeta_node_0F"
                a.path.append(a.position)
            new_agents.append(a)
        self.agents = [a for a in new_agents if a.alive][:64]

    def run(self, steps: int = 20) -> List[Agent]:
        for _ in range(steps):
            self.step()
            if any(a.position == "zeta_node_0F" for a in self.agents):
                break
        return [a for a in self.agents if a.position == "zeta_node_0F"]


def demo() -> None:
    eng = BifurcationEngine(n_agents=4)
    winners = eng.run(steps=30)
    print(f"Bifurcation engine: clock={eng.clock} forks={eng.fork_count}")
    print(f"  live={len(eng.agents)} reached_goal={len(winners)}")
    print(f"  μ sample={compute_mu([1]*10):.4f}")
    print("Bifurcation chaos: OK")


if __name__ == "__main__":
    demo()
