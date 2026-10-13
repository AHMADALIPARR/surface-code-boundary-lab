#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
Spine 64 Hex Cipher

Token format: 0x<prime_hex>.<frac>
  - prime_hex : hexadecimal encoding of the prime (lossless)
  - frac      : 4 hex digits; first pair ~ floor(gamma) + offset,
                second pair = sequential counter (step 0x22)

Multiplicity e_k is stored alongside the token, not inside it.
"""

from __future__ import annotations
from dataclasses import dataclass
from typing import List, Optional

# First 16 entries from the cipher matrix (illustrative)
_SEED = [
    # (k, prime, gamma, e, token)
    (0x00, 2, 14.1347, 1, "0x02.14AB"),
    (0x01, 3, 21.0220, 2, "0x03.21CD"),
    (0x02, 5, 25.0108, 1, "0x05.25EF"),
    (0x03, 7, 30.4248, 3, "0x07.3012"),
    (0x04, 11, 32.9351, 1, "0x0B.3234"),
    (0x05, 13, 37.5862, 2, "0x0D.3756"),
    (0x06, 17, 40.9187, 1, "0x11.4078"),
    (0x07, 19, 43.3271, 4, "0x13.439A"),
    (0x08, 23, 48.0051, 1, "0x17.48BC"),
    (0x09, 29, 49.7738, 2, "0x1D.4FDE"),
    (0x0A, 31, 52.9703, 1, "0x1F.5301"),
    (0x0B, 37, 56.4462, 3, "0x25.5623"),
    (0x0C, 41, 59.3470, 1, "0x29.5945"),
    (0x0D, 43, 60.8318, 2, "0x2B.6067"),
    (0x0E, 47, 65.1125, 1, "0x2F.6589"),
    (0x0F, 53, 67.0798, 5, "0x35.67AB"),
]

@dataclass
class CipherEntry:
    index: int
    prime: int
    gamma: float
    multiplicity: int
    token: str

    def layer(self) -> int:
        """Map index to Premidoral layer 0..63."""
        return self.index % 64

    def even_layer(self) -> bool:
        return self.layer() % 2 == 0


def encode(prime: int, tag: str = "0000") -> str:
    """Encode a prime as a hex-cipher token. Tag is 4 hex digits."""
    if not (0 <= prime <= 0xFFFF):
        raise ValueError("prime out of 16-bit range")
    tag = tag.upper().zfill(4)[-4:]
    return f"0x{prime:02X}.{tag}"


def decode(token: str) -> int:
    """Extract the prime from a token. Raises ValueError on malformed input."""
    token = token.strip().lower()
    if not token.startswith("0x") or "." not in token:
        raise ValueError(f"malformed token: {token}")
    int_part = token.split(".")[0][2:]
    return int(int_part, 16)


def load_seed() -> List[CipherEntry]:
    return [
        CipherEntry(k, p, g, e, tok)
        for k, p, g, e, tok in _SEED
    ]


def verify_roundtrip(entries: Optional[List[CipherEntry]] = None) -> bool:
    entries = entries or load_seed()
    ok = True
    for ent in entries:
        recovered = decode(ent.token)
        if recovered != ent.prime:
            print(f"FAIL k={ent.index:02x}: {ent.token} -> {recovered} != {ent.prime}")
            ok = False
    return ok


def main() -> None:
    entries = load_seed()
    print(f"Spine 64 Hex Cipher — {len(entries)} seed entries")
    print(f"{'k':>4} {'prime':>6} {'e':>3} {'layer':>5} {'token':>12} {'even':>5}")
    for ent in entries:
        print(f"{ent.index:4x} {ent.prime:6} {ent.multiplicity:3} {ent.layer():5} {ent.token:>12} {str(ent.even_layer()):>5}")
    print()
    if verify_roundtrip(entries):
        print("Round-trip: all primes recovered")
    else:
        print("Round-trip: failures detected")


if __name__ == "__main__":
    main()
