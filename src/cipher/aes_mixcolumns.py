#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
AES MixColumns (and InvMixColumns).

Operates on a 4x4 state matrix of bytes (column-major, as in FIPS 197).
Multiplication is in GF(2^8) with irreducible polynomial x^8 + x^4 + x^3 + x + 1.
"""

from typing import List

# AES state: 4 rows x 4 columns, each entry 0..255
State = List[List[int]]

def xtime(a: int) -> int:
    """Multiply by x (i.e., 2) in GF(2^8)."""
    a &= 0xFF
    return ((a << 1) ^ 0x1B) & 0xFF if (a & 0x80) else (a << 1) & 0xFF

def mul(a: int, b: int) -> int:
    """Multiply two bytes in GF(2^8)."""
    result = 0
    for _ in range(8):
        if b & 1:
            result ^= a
        a = xtime(a)
        b >>= 1
    return result & 0xFF

def mix_column(col: List[int]) -> List[int]:
    """Mix one column (4 bytes) with the AES matrix [[2,3,1,1],[1,2,3,1],[1,1,2,3],[3,1,1,2]]."""
    a0, a1, a2, a3 = col
    return [
        mul(a0, 2) ^ mul(a1, 3) ^ a2 ^ a3,
        a0 ^ mul(a1, 2) ^ mul(a2, 3) ^ a3,
        a0 ^ a1 ^ mul(a2, 2) ^ mul(a3, 3),
        mul(a0, 3) ^ a1 ^ a2 ^ mul(a3, 2),
    ]

def inv_mix_column(col: List[int]) -> List[int]:
    """Inverse MixColumns with matrix [[14,11,13,9],[9,14,11,13],[13,9,14,11],[11,13,9,14]]."""
    a0, a1, a2, a3 = col
    return [
        mul(a0, 14) ^ mul(a1, 11) ^ mul(a2, 13) ^ mul(a3, 9),
        mul(a0, 9) ^ mul(a1, 14) ^ mul(a2, 11) ^ mul(a3, 13),
        mul(a0, 13) ^ mul(a1, 9) ^ mul(a2, 14) ^ mul(a3, 11),
        mul(a0, 11) ^ mul(a1, 13) ^ mul(a2, 9) ^ mul(a3, 14),
    ]

def mix_columns(state: State) -> State:
    """Apply MixColumns to all four columns. Returns a new state."""
    out = [[0] * 4 for _ in range(4)]
    for c in range(4):
        col = [state[r][c] for r in range(4)]
        mixed = mix_column(col)
        for r in range(4):
            out[r][c] = mixed[r]
    return out

def inv_mix_columns(state: State) -> State:
    """Apply InvMixColumns to all four columns."""
    out = [[0] * 4 for _ in range(4)]
    for c in range(4):
        col = [state[r][c] for r in range(4)]
        mixed = inv_mix_column(col)
        for r in range(4):
            out[r][c] = mixed[r]
    return out

def state_from_hex(h: str) -> State:
    """Parse 32 hex chars into a column-major 4x4 state."""
    h = h.replace(" ", "").replace("0x", "")
    if len(h) != 32:
        raise ValueError("need 32 hex chars")
    raw = bytes.fromhex(h)
    state = [[0] * 4 for _ in range(4)]
    for i, b in enumerate(raw):
        state[i % 4][i // 4] = b
    return state

def state_to_hex(state: State) -> str:
    raw = bytearray(16)
    for c in range(4):
        for r in range(4):
            raw[c * 4 + r] = state[r][c]
    return raw.hex()

def demo() -> None:
    # FIPS 197 Appendix B example (after ShiftRows, before MixColumns)
    # Column 0 input: d4 bf 5d 30 → 04 66 81 e5
    col = [0xD4, 0xBF, 0x5D, 0x30]
    mixed = mix_column(col)
    print(f"MixColumns({[hex(x) for x in col]}) = {[hex(x) for x in mixed]}")
    assert mixed == [0x04, 0x66, 0x81, 0xE5], mixed

    recovered = inv_mix_column(mixed)
    print(f"InvMixColumns round-trip: {[hex(x) for x in recovered]}")
    assert recovered == col

    print("AES MixColumns: OK")

if __name__ == "__main__":
    demo()
