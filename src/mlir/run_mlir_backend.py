#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# Copyright (C) 2026 SnapKitty Collective
#
# MLIR-style surface-code runner that injects entropy from the
# ANU Quantum Random Number Generator (vacuum fluctuations).
# Multiplicity mixing: XOR k independent QRNG samples before use.

import json
import urllib.request
import random
from typing import List

ANU_URL = "https://qrng.anu.edu.au/API/jsonI.php"

def fetch_anu_qrng(length: int = 16, multiplicity: int = 2) -> List[int]:
    """Fetch uint8 quantum random numbers from ANU QRNG.
    Multiplicity: request `multiplicity` batches and XOR them bytewise.
    Rate limit on the legacy endpoint is ~1 req/min; callers should cache.
    """
    batches = []
    for _ in range(max(1, multiplicity)):
        url = f"{ANU_URL}?length={length}&type=uint8"
        with urllib.request.urlopen(url, timeout=15) as resp:
            payload = json.loads(resp.read().decode())
        if not payload.get("success"):
            raise RuntimeError(f"ANU QRNG failed: {payload}")
        batches.append(payload["data"])
    # Multiplicity mixing: XOR corresponding bytes
    mixed = [0] * length
    for batch in batches:
        for i, b in enumerate(batch[:length]):
            mixed[i] ^= b
    return mixed

class EntropySource:
    """Caches ANU QRNG bytes and yields uniform floats in [0,1)."""
    def __init__(self, multiplicity: int = 2, cache_size: int = 64):
        self.multiplicity = multiplicity
        self.cache: List[int] = []
        self.cache_size = cache_size
        self._refill()

    def _refill(self):
        try:
            self.cache.extend(fetch_anu_qrng(self.cache_size, self.multiplicity))
            print(f"[ANU] fetched {self.cache_size} bytes (multiplicity={self.multiplicity})")
        except Exception as e:
            print(f"[ANU] fallback to system RNG: {e}")
            self.cache.extend(random.randrange(256) for _ in range(self.cache_size))

    def uniform(self) -> float:
        if not self.cache:
            self._refill()
        byte = self.cache.pop(0)
        return byte / 256.0

    def bits(self, n: int) -> List[int]:
        return [1 if self.uniform() < 0.5 else 0 for _ in range(n)]

class SurfaceCodeMLIR:
    """Minimal interpreter for the SurfaceCode dialect sketch."""
    def __init__(self, distance: int = 3, entropy: EntropySource | None = None):
        self.d = distance
        self.n = distance * distance
        self.data = [0] * self.n
        self.entropy = entropy or EntropySource()

    def apply_x(self, idx: int):
        if 0 <= idx < self.n:
            self.data[idx] ^= 1

    def inject_entropy(self, p: float = 0.001):
        """Depolarizing-style injection using ANU vacuum-fluctuation bits."""
        for i in range(self.n):
            if self.entropy.uniform() < p:
                self.apply_x(i)

    def measure_z_bulk(self) -> List[int]:
        def parity(*idxs):
            return sum(self.data[i] for i in idxs) & 1
        d = self.d
        faces = []
        for y in range(d - 1):
            for x in range(d - 1):
                i0 = y * d + x
                i1 = y * d + x + 1
                i2 = (y + 1) * d + x
                i3 = (y + 1) * d + x + 1
                faces.append(parity(i0, i1, i2, i3))
        return faces

    def logical_z(self) -> int:
        return sum(self.data[x] for x in range(self.d)) & 1

    def run(self, rounds: int = 3, fault: int = 4, noise_p: float = 0.001):
        print(f"MLIR surface-code runner d={self.d}")
        if 0 <= fault < self.n:
            self.apply_x(fault)
        self.inject_entropy(noise_p)
        for r in range(rounds):
            synd = self.measure_z_bulk()
            print(f"  round {r}: Z-bulk {synd}")
        print(f"Logical Z: {self.logical_z()}")

def main():
    ent = EntropySource(multiplicity=2, cache_size=32)
    sim = SurfaceCodeMLIR(distance=3, entropy=ent)
    sim.run(rounds=3, fault=4, noise_p=0.01)

if __name__ == "__main__":
    main()
