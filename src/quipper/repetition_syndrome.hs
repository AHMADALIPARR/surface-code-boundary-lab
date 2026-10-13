-- SPDX-License-Identifier: AGPL-3.0-or-later
-- Copyright (C) 2026 SnapKitty Collective
-- Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

-- Quipper description of a small surface-code Z-stabilizer fragment.
-- 4 data qubits + 2 ancillas. Layout matches the Q# / CUDA-Q kernels.
module Main where

import Quipper

surfaceStabilizer :: Circ (Bit, Bit)
surfaceStabilizer = do
  d0 <- qinit False
  d1 <- qinit False
  d2 <- qinit False
  d3 <- qinit False
  a0 <- qinit False
  a1 <- qinit False

  -- Deterministic X fault on d1.
  d1 <- qnot d1

  -- Face 0: Z(d0)Z(d1)Z(d2)
  a0 <- qnot a0 `controlled` d0
  a0 <- qnot a0 `controlled` d1
  a0 <- qnot a0 `controlled` d2

  -- Face 1: Z(d1)Z(d3)
  a1 <- qnot a1 `controlled` d1
  a1 <- qnot a1 `controlled` d3

  s0 <- measure a0
  s1 <- measure a1

  mapM_ qdiscard [d0, d1, d2, d3]
  return (s0, s1)

main :: IO ()
main = print_simple ASCII surfaceStabilizer
