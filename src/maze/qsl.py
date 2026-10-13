#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
QSL kernel: Quantum Separation Logic (heap isolation) and
Quantum Speed Limit (Mandelstam-Tamm / Margolus-Levitin bounds).
"""

from __future__ import annotations
import math
from typing import Tuple

# Reduced constants for demo (not SI)
HBAR = 1.0
PLANCK_TIME = 1e-6  # demo floor

def padic_distance(a: int, b: int, p: int = 2) -> float:
    """Ultrametric distance p^{-v_p(a-b)}."""
    d = a ^ b  # for p=2, valuation is trailing zeros of XOR
    if d == 0:
        return 0.0
    v = (d & -d).bit_length() - 1
    return p ** (-v)

def heap_isolated(addr_a: int, addr_b: int, epsilon: float = 0.1) -> bool:
    """Separation: ultrametric distance exceeds threshold."""
    return padic_distance(addr_a, addr_b) > epsilon

def mandelstam_tamm(delta_h: float) -> float:
    """τ_MT = π ℏ / (2 ΔH)."""
    if delta_h <= 0:
        return float("inf")
    return (math.pi * HBAR) / (2.0 * delta_h)

def margolus_levitin(mean_h: float) -> float:
    """τ_ML = π ℏ / (2 ⟨H⟩)."""
    if mean_h <= 0:
        return float("inf")
    return (math.pi * HBAR) / (2.0 * mean_h)

def qsl_time(delta_h: float, mean_h: float) -> float:
    """τ_QSL = max(τ_MT, τ_ML), floored at Planck time."""
    return max(mandelstam_tamm(delta_h), margolus_levitin(mean_h), PLANCK_TIME)

def verify_speed_limit(elapsed: float, delta_h: float, mean_h: float) -> bool:
    """True if elapsed time respects the QSL bound."""
    return elapsed >= qsl_time(delta_h, mean_h)

def verify_separation(pairs: list[Tuple[int, int]], epsilon: float = 0.1) -> bool:
    """True if every address pair is isolated."""
    return all(heap_isolated(a, b, epsilon) for a, b in pairs)


def demo() -> None:
    print("QSL demo")
    print(f"  padic(1,3)={padic_distance(1,3):.4f}")
    print(f"  isolated(0,1)={heap_isolated(0,1)}")
    print(f"  τ_MT(1.0)={mandelstam_tamm(1.0):.4f}")
    print(f"  τ_QSL(1,1)={qsl_time(1.0,1.0):.4f}")
    print(f"  speed ok={verify_speed_limit(2.0, 1.0, 1.0)}")
    print(f"  sep ok={verify_separation([(0,8),(1,4)])}")


if __name__ == "__main__":
    demo()
