-- SPDX-License-Identifier: AGPL-3.0-or-later
-- Copyright (C) 2026 SnapKitty Collective
-- Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

-- Quipper description of a distance-3 rotated surface-code Z-stabilizer round.
-- 9 data qubits + 4 ancillas. Layout matches the Q# and CUDA-Q kernels.
-- The exact Quipper API should be verified against the installed version.

module Main where

import Quipper

-- Apply a Z-stabilizer on four data qubits into one ancilla.
zStabilizer :: Qubit -> Qubit -> Qubit -> Qubit -> Qubit -> Circ Qubit
zStabilizer d0 d1 d2 d3 a = do
  a <- qnot a `controlled` d0
  a <- qnot a `controlled` d1
  a <- qnot a `controlled` d2
  a <- qnot a `controlled` d3
  return a

surfaceCodeRound :: Circ [Bit]
surfaceCodeRound = do
  -- 9 data qubits
  d <- mapM (const (qinit False)) [1..9]
  -- 4 ancillas
  a0 <- qinit False
  a1 <- qinit False
  a2 <- qinit False
  a3 <- qinit False

  -- Deterministic X fault on center data qubit (index 4).
  d4' <- qnot (d !! 4)
  let d' = take 4 d ++ [d4'] ++ drop 5 d

  -- Four face stabilizers.
  a0' <- zStabilizer (d' !! 0) (d' !! 1) (d' !! 3) (d' !! 4) a0
  a1' <- zStabilizer (d' !! 1) (d' !! 2) (d' !! 4) (d' !! 5) a1
  a2' <- zStabilizer (d' !! 3) (d' !! 4) (d' !! 6) (d' !! 7) a2
  a3' <- zStabilizer (d' !! 4) (d' !! 5) (d' !! 7) (d' !! 8) a3

  s0 <- measure a0'
  s1 <- measure a1'
  s2 <- measure a2'
  s3 <- measure a3'

  mapM_ qdiscard d'
  return [s0, s1, s2, s3]

main :: IO ()
main = print_simple ASCII surfaceCodeRound
