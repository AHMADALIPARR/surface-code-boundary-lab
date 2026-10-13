#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
Minimal quantum circuit simulator (statevector).

Supports H, X, Z, CNOT, and custom oracle hooks that can call
the cipher packages (Z408, Z340, AES MixColumns, hex cipher).
"""

from __future__ import annotations
import math
import cmath
from typing import Callable, List, Optional

class Statevector:
    def __init__(self, n: int):
        self.n = n
        self.amp = [0j] * (1 << n)
        self.amp[0] = 1+0j

    def apply_1q(self, gate: List[List[complex]], q: int) -> None:
        """Apply 2x2 gate to qubit q."""
        n = self.n
        new = [0j] * (1 << n)
        for i in range(1 << n):
            bit = (i >> q) & 1
            i0 = i & ~(1 << q)
            i1 = i | (1 << q)
            a0, a1 = self.amp[i0], self.amp[i1]
            if bit == 0:
                new[i0] += gate[0][0] * a0 + gate[0][1] * a1
                new[i1] += gate[1][0] * a0 + gate[1][1] * a1
        # The loop double-counts; rebuild properly
        new = [0j] * (1 << n)
        for i in range(1 << n):
            if (i >> q) & 1:
                continue
            i0, i1 = i, i | (1 << q)
            a0, a1 = self.amp[i0], self.amp[i1]
            new[i0] = gate[0][0]*a0 + gate[0][1]*a1
            new[i1] = gate[1][0]*a0 + gate[1][1]*a1
        self.amp = new

    def h(self, q: int) -> None:
        s = 1/math.sqrt(2)
        self.apply_1q([[s, s], [s, -s]], q)

    def x(self, q: int) -> None:
        self.apply_1q([[0, 1], [1, 0]], q)

    def z(self, q: int) -> None:
        self.apply_1q([[1, 0], [0, -1]], q)

    def cnot(self, c: int, t: int) -> None:
        n = self.n
        new = list(self.amp)
        for i in range(1 << n):
            if (i >> c) & 1:
                j = i ^ (1 << t)
                if i < j:
                    new[i], new[j] = self.amp[j], self.amp[i]
        self.amp = new

    def measure_all(self) -> int:
        """Sample a bitstring; returns integer outcome."""
        import random
        probs = [abs(a)**2 for a in self.amp]
        r = random.random()
        acc = 0.0
        for i, p in enumerate(probs):
            acc += p
            if r <= acc:
                return i
        return len(probs) - 1

    def probs(self) -> List[float]:
        return [abs(a)**2 for a in self.amp]


class Circuit:
    def __init__(self, n: int):
        self.n = n
        self.ops: List[tuple] = []

    def h(self, q: int): self.ops.append(("h", q)); return self
    def x(self, q: int): self.ops.append(("x", q)); return self
    def z(self, q: int): self.ops.append(("z", q)); return self
    def cnot(self, c: int, t: int): self.ops.append(("cnot", c, t)); return self
    def oracle(self, fn: Callable[[Statevector], None], name: str = "oracle"):
        self.ops.append(("oracle", fn, name)); return self

    def run(self, shots: int = 1) -> Statevector:
        sv = Statevector(self.n)
        for op in self.ops:
            if op[0] == "h": sv.h(op[1])
            elif op[0] == "x": sv.x(op[1])
            elif op[0] == "z": sv.z(op[1])
            elif op[0] == "cnot": sv.cnot(op[1], op[2])
            elif op[0] == "oracle": op[1](sv)
        return sv


def demo() -> None:
    # Bell state
    c = Circuit(2).h(0).cnot(0, 1)
    sv = c.run()
    print("Bell probs:", [round(p, 3) for p in sv.probs()])
    # Single H
    c2 = Circuit(1).h(0)
    print("H probs:", [round(p, 3) for p in c2.run().probs()])
    print("Simulator: OK")


if __name__ == "__main__":
    demo()
