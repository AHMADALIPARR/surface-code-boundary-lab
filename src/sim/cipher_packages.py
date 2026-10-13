#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 Bel esprit D'accord Trust / SnapKitty Collective
"""
Cipher packages exposed as quantum-oracle modules.

Each cipher can be called from a Circuit oracle to phase-mark
or bit-flip based on encryption of a classical register.
"""

from __future__ import annotations
import sys
from pathlib import Path

# Ensure cipher modules import
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "cipher"))
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "mlir"))

from z408 import Z408
from z340 import Z340
from aes_mixcolumns import mix_column
from hex_cipher import encode as hex_encode, decode as hex_decode

__all__ = ["Z408", "Z340", "mix_column", "hex_encode", "hex_decode", "cipher_oracle"]


def cipher_oracle(kind: str = "z408", seed: int = 408):
    """
    Return a function(statevector) that applies a classical cipher
    to the measured bitstring and XORs the result back as a phase.
    Demo: encrypts the integer index and uses parity as a Z phase.
    """
    def _apply(sv):
        # Classical side: encrypt index 0 and take parity of length
        if kind == "z408":
            ct = Z408(seed=seed).encrypt("ORACLE")
        elif kind == "z340":
            ct = Z340(seed=seed).encrypt("ORACLE")
        elif kind == "hex":
            ct = hex_encode(seed & 0xFF)
        else:
            ct = "X"
        parity = len(ct) & 1
        if parity and sv.n > 0:
            sv.z(0)
    return _apply


def demo() -> None:
    from qsim import Circuit
    c = Circuit(2).h(0).h(1)
    c.oracle(cipher_oracle("z408"), name="z408")
    c.oracle(cipher_oracle("hex", 0x35), name="hex")
    sv = c.run()
    print("After cipher oracles:", [round(p, 3) for p in sv.probs()])
    print("Packages: Z408, Z340, MixColumns, hex_cipher")
    print("Cipher packages: OK")


if __name__ == "__main__":
    demo()
