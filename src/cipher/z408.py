#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
Z408-style cipher: homophonic substitution with transposition and
reverse/mirror reading paths.

Historical note: The 1969 Zodiac 408-character cryptogram used a
homophonic substitution (multiple symbols per plaintext letter) and
was read in conventional left-to-right order after decryption. This
module implements the mechanical components—homophonic mapping,
section transposition, and reversible/mirror traversal—for study.
It does not reproduce the original solved plaintext.
"""

from __future__ import annotations
import random
from typing import Dict, List, Optional

# Homophonic alphabet: each plaintext letter maps to one or more symbols.
# Symbols here are printable stand-ins; the original used a custom glyph set.
DEFAULT_HOMOPHONES: Dict[str, List[str]] = {
    "E": ["!", "@", "#"],
    "T": ["$", "%"],
    "A": ["&", "*"],
    "O": ["(", ")"],
    "I": ["-", "="],
    "N": ["+", "["],
    "S": ["]", "{"],
    "H": ["}", "|"],
    "R": [";", ":"],
    "D": ["<", ">"],
    "L": [",", "."],
    "C": ["?", "/"],
    "U": ["~", "`"],
    "M": ["^"],
    "W": ["_"],
    "F": ["\\"],
    "G": ["\""],
    "Y": ["'"],
    "P": ["0"],
    "B": ["1"],
    "V": ["2"],
    "K": ["3"],
    "J": ["4"],
    "X": ["5"],
    "Q": ["6"],
    "Z": ["7"],
}

def build_reverse_map(homophones: Dict[str, List[str]]) -> Dict[str, str]:
    """Symbol -> plaintext letter."""
    rev: Dict[str, str] = {}
    for letter, symbols in homophones.items():
        for s in symbols:
            rev[s] = letter
    return rev

class Z408:
    def __init__(self, homophones: Optional[Dict[str, List[str]]] = None, seed: int = 0):
        self.homophones = homophones or DEFAULT_HOMOPHONES
        self.reverse = build_reverse_map(self.homophones)
        self.rng = random.Random(seed)

    def encrypt_char(self, ch: str) -> str:
        ch = ch.upper()
        if ch not in self.homophones:
            return ch  # pass through spaces/punctuation
        choices = self.homophones[ch]
        return self.rng.choice(choices)

    def encrypt(self, plaintext: str) -> str:
        return "".join(self.encrypt_char(c) for c in plaintext)

    def decrypt_char(self, symbol: str) -> str:
        return self.reverse.get(symbol, symbol)

    def decrypt(self, ciphertext: str) -> str:
        return "".join(self.decrypt_char(s) for s in ciphertext)

    # --- Transposition / reading paths ---

    @staticmethod
    def reverse_read(text: str) -> str:
        """Read the string backwards."""
        return text[::-1]

    @staticmethod
    def mirror_pairs(text: str, width: int = 17) -> str:
        """
        Mirror reading: reverse each row of `width` characters.
        Z408 was arranged in 17-column rows; this mimics a mirror-path variant.
        """
        rows = [text[i:i+width] for i in range(0, len(text), width)]
        return "".join(row[::-1] for row in rows)

    @staticmethod
    def transpose_sections(text: str, section_len: int = 8) -> str:
        """
        Simple section transposition: reverse the order of fixed-length sections.
        """
        sections = [text[i:i+section_len] for i in range(0, len(text), section_len)]
        sections.reverse()
        return "".join(sections)

    def encrypt_with_path(self, plaintext: str, path: str = "forward") -> str:
        ct = self.encrypt(plaintext)
        if path == "reverse":
            return self.reverse_read(ct)
        if path == "mirror":
            return self.mirror_pairs(ct)
        if path == "sections":
            return self.transpose_sections(ct)
        return ct

    def decrypt_with_path(self, ciphertext: str, path: str = "forward") -> str:
        if path == "reverse":
            ciphertext = self.reverse_read(ciphertext)
        elif path == "mirror":
            ciphertext = self.mirror_pairs(ciphertext)
        elif path == "sections":
            ciphertext = self.transpose_sections(ciphertext)
        return self.decrypt(ciphertext)


def demo() -> None:
    z = Z408(seed=408)
    sample = "THE QUICK BROWN FOX"
    print(f"Plain:     {sample}")

    for path in ("forward", "reverse", "mirror", "sections"):
        ct = z.encrypt_with_path(sample, path)
        pt = z.decrypt_with_path(ct, path)
        print(f"{path:10} ct={ct}")
        print(f"{'':10} pt={pt} match={pt.replace(' ','') == sample.replace(' ','')}")

    print("Z408 mechanics: OK")


if __name__ == "__main__":
    demo()
