#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
Z340-style cipher: homophonic substitution plus slanted/diagonal
transposition on a 17-column grid with periodic row flips.

Historical note: The 340-character Zodiac cryptogram (solved 2020)
used a homophonic substitution and a transposition in which reading
direction reversed at periodic intervals across a 17-column layout.
This module implements those mechanical components for study.
It does not reproduce the original solved plaintext.
"""

from __future__ import annotations
from typing import List, Optional
from z408 import Z408, DEFAULT_HOMOPHONES

GRID_WIDTH = 17
FLIP_PERIOD = 9   # direction reverses every N rows (illustrative)

class Z340(Z408):
    """Extends Z408 with diagonal and periodic-flip reading paths."""

    def __init__(self, seed: int = 340):
        super().__init__(homophones=DEFAULT_HOMOPHONES, seed=seed)

    # --- Grid helpers ---

    @staticmethod
    def to_grid(text: str, width: int = GRID_WIDTH) -> List[str]:
        return [text[i:i+width] for i in range(0, len(text), width)]

    @staticmethod
    def from_grid(rows: List[str]) -> str:
        return "".join(rows)

    # --- Transposition paths ---

    def periodic_flip(self, text: str, width: int = GRID_WIDTH,
                      period: int = FLIP_PERIOD) -> str:
        """
        Reverse every `period`-th row (1-based). Mimics the Z340
        pattern of reading direction folding back at intervals.
        """
        rows = self.to_grid(text, width)
        out = []
        for i, row in enumerate(rows):
            if (i + 1) % period == 0:
                out.append(row[::-1])
            else:
                out.append(row)
        return self.from_grid(out)

    def diagonal_read(self, text: str, width: int = GRID_WIDTH) -> str:
        """
        Read the grid along descending diagonals (row+col constant),
        alternating direction per diagonal.
        """
        rows = self.to_grid(text, width)
        if not rows:
            return text
        height = len(rows)
        # Pad last row
        rows = [r.ljust(width) for r in rows]
        result = []
        for s in range(height + width - 1):
            diag = []
            for r in range(height):
                c = s - r
                if 0 <= c < width:
                    diag.append(rows[r][c])
            if s % 2 == 1:
                diag.reverse()
            result.extend(diag)
        return "".join(result).rstrip()

    def undo_diagonal(self, text: str, width: int = GRID_WIDTH,
                      length: Optional[int] = None) -> str:
        """Inverse of diagonal_read for a known original length."""
        length = length or len(text)
        height = (length + width - 1) // width
        # Build diagonal index map
        positions = []
        for s in range(height + width - 1):
            diag = []
            for r in range(height):
                c = s - r
                if 0 <= c < width and r * width + c < length:
                    diag.append((r, c))
            if s % 2 == 1:
                diag.reverse()
            positions.extend(diag)
        grid = [[' '] * width for _ in range(height)]
        for i, (r, c) in enumerate(positions):
            if i < len(text):
                grid[r][c] = text[i]
        return "".join("".join(row) for row in grid)[:length]

    def encrypt_z340(self, plaintext: str, path: str = "flip") -> str:
        ct = self.encrypt(plaintext)
        if path == "flip":
            return self.periodic_flip(ct)
        if path == "diagonal":
            return self.diagonal_read(ct)
        if path == "flip+diagonal":
            return self.diagonal_read(self.periodic_flip(ct))
        return ct

    def decrypt_z340(self, ciphertext: str, path: str = "flip",
                     length: Optional[int] = None) -> str:
        if path == "flip":
            ciphertext = self.periodic_flip(ciphertext)  # involution
        elif path == "diagonal":
            ciphertext = self.undo_diagonal(ciphertext, length=length or len(ciphertext))
        elif path == "flip+diagonal":
            ciphertext = self.undo_diagonal(ciphertext, length=length or len(ciphertext))
            ciphertext = self.periodic_flip(ciphertext)
        return self.decrypt(ciphertext)


def demo() -> None:
    z = Z340(seed=340)
    sample = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG" * 2
    print(f"Plain length: {len(sample)}")

    for path in ("flip", "diagonal"):
        ct = z.encrypt_z340(sample, path)
        pt = z.decrypt_z340(ct, path, length=len(sample))
        match = pt.replace(" ", "") == sample.replace(" ", "")
        print(f"{path:12} round-trip={match} ct[:40]={ct[:40]!r}")

    print("Z340 mechanics: OK")


if __name__ == "__main__":
    demo()
