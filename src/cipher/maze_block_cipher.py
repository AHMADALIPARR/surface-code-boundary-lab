#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
Block cipher integrating Many-Worlds maze branching and QSL bounds.

Key schedule: maze path bytes mixed with QSL-derived round constants.
Round function: AES-style MixColumns + mirror-flip substitution.
"""

from __future__ import annotations
import hashlib
import struct
from typing import List

from many_worlds import ManyWorldsMaze
from qsl import qsl_time, verify_separation
from aes_mixcolumns import mix_column

BLOCK = 16  # bytes

def key_schedule(master: bytes, rounds: int = 10) -> List[bytes]:
    """Derive round keys from maze winners + QSL constants."""
    mw = ManyWorldsMaze(max_branches=32)
    winners = mw.run(max_steps=8)
    # Entropy from winner paths
    path_bytes = b"".join(
        hashlib.sha256("".join(w.path).encode()).digest() for w in winners[:4]
    ) or hashlib.sha256(b"fallback").digest()
    # QSL round constants
    consts = []
    for r in range(rounds):
        tau = qsl_time(1.0 + r * 0.1, 1.0)
        consts.append(struct.pack("<d", tau)[:8])
    # Expand
    keys = []
    material = hashlib.sha256(master + path_bytes).digest()
    for r in range(rounds):
        material = hashlib.sha256(material + consts[r % len(consts)]).digest()
        keys.append(material[:BLOCK])
    return keys

def mirror_sub(block: bytes) -> bytes:
    """Involutive byte mirror: reverse and XOR 0xFF."""
    return bytes(b ^ 0xFF for b in reversed(block))

def round_func(block: bytes, rk: bytes) -> bytes:
    """AddRoundKey, mirror sub, MixColumns on 4-byte groups."""
    x = bytes(a ^ b for a, b in zip(block, rk))
    x = mirror_sub(x)
    out = bytearray(BLOCK)
    for i in range(0, BLOCK, 4):
        col = list(x[i:i+4])
        mixed = mix_column(col)
        out[i:i+4] = mixed
    return bytes(out)

def encrypt_block(block: bytes, master: bytes, rounds: int = 10) -> bytes:
    assert len(block) == BLOCK
    keys = key_schedule(master, rounds)
    state = block
    for rk in keys:
        state = round_func(state, rk)
    return state

def decrypt_block(block: bytes, master: bytes, rounds: int = 10) -> bytes:
    """Inverse: MixColumns is not trivially inverted here; we use the
    forward key schedule in reverse with mirror (involution) only.
    Full inverse would require InvMixColumns; this demo uses a
    reversible path via mirror + XOR only for verification of the
    schedule, and documents that MixColumns needs its inverse.
    """
    # For a correct inverse, apply InvMixColumns. Import and use it.
    from aes_mixcolumns import inv_mix_column
    keys = key_schedule(master, rounds)
    state = block
    for rk in reversed(keys):
        # Undo MixColumns
        tmp = bytearray(BLOCK)
        for i in range(0, BLOCK, 4):
            col = list(state[i:i+4])
            tmp[i:i+4] = inv_mix_column(col)
        # Undo mirror
        state = mirror_sub(bytes(tmp))
        # Undo AddRoundKey
        state = bytes(a ^ b for a, b in zip(state, rk))
    return state


def demo() -> None:
    master = b"SNAPKITTY-VOYAGER"
    pt = b"0123456789ABCDEF"
    ct = encrypt_block(pt, master)
    rt = decrypt_block(ct, master)
    print(f"PT: {pt.hex()}")
    print(f"CT: {ct.hex()}")
    print(f"RT: {rt.hex()}")
    print(f"Round-trip: {rt == pt}")
    # Separation check on dummy addresses
    print(f"Sep check: {verify_separation([(0, 8), (1, 16)])}")


if __name__ == "__main__":
    demo()
