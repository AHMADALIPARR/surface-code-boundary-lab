-- SPDX-License-Identifier: AGPL-3.0-or-later
-- Copyright (C) 2026 SnapKitty Collective
-- Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

-- Quipper description of a distance-3 rotated surface-code stabilizer round.
-- 9 data qubits + 4 Z-ancillas + 4 X-ancillas.
-- Layout matches the Q# and CUDA-Q kernels.
-- Verify the Quipper API against the installed version before release.

module Main where

import Quipper

-- Apply a Z-type four-qubit face check into an ancilla.
zFace :: Qubit -> Qubit -> Qubit -> Qubit -> Qubit -> Circ Qubit
zFace d0 d1 d2 d3 a = do
  a <- qnot a `controlled` d0
  a <- qnot a `controlled` d1
  a <- qnot a `controlled` d2
  a <- qnot a `controlled` d3
  return a

-- Apply an X-type face check (Hadamard sandwich) into an ancilla.
xFace :: Qubit -> Qubit -> Qubit -> Qubit -> Qubit -> Circ Qubit
xFace d0 d1 d2 d3 a = do
  d0 <- hadamard d0
  d1 <- hadamard d1
  d2 <- hadamard d2
  d3 <- hadamard d3
  a  <- qnot a `controlled` d0
  a  <- qnot a `controlled` d1
  a  <- qnot a `controlled` d2
  a  <- qnot a `controlled` d3
  d0 <- hadamard d0
  d1 <- hadamard d1
  d2 <- hadamard d2
  d3 <- hadamard d3
  return a

-- Inject a deterministic X fault on a data qubit (by index).
injectX :: [Qubit] -> Int -> Circ [Qubit]
injectX qs i = do
  let (pre, q:post) = splitAt i qs
  q' <- qnot q
  return (pre ++ [q'] ++ post)

-- One Z-stabilizer round over the four faces.
zRound :: [Qubit] -> [Qubit] -> Circ [Bit]
zRound d [a0, a1, a2, a3] = do
  a0' <- zFace (d !! 0) (d !! 1) (d !! 3) (d !! 4) a0
  a1' <- zFace (d !! 1) (d !! 2) (d !! 4) (d !! 5) a1
  a2' <- zFace (d !! 3) (d !! 4) (d !! 6) (d !! 7) a2
  a3' <- zFace (d !! 4) (d !! 5) (d !! 7) (d !! 8) a3
  s0 <- measure a0'
  s1 <- measure a1'
  s2 <- measure a2'
  s3 <- measure a3'
  return [s0, s1, s2, s3]

-- One X-stabilizer round over the four faces.
xRound :: [Qubit] -> [Qubit] -> Circ [Bit]
xRound d [a0, a1, a2, a3] = do
  a0' <- xFace (d !! 0) (d !! 1) (d !! 3) (d !! 4) a0
  a1' <- xFace (d !! 1) (d !! 2) (d !! 4) (d !! 5) a1
  a2' <- xFace (d !! 3) (d !! 4) (d !! 6) (d !! 7) a2
  a3' <- xFace (d !! 4) (d !! 5) (d !! 7) (d !! 8) a3
  s0 <- measure a0'
  s1 <- measure a1'
  s2 <- measure a2'
  s3 <- measure a3'
  return [s0, s1, s2, s3]

-- Full syndrome extraction: Z round then X round.
syndromeRound :: [Qubit] -> [Qubit] -> [Qubit] -> Circ ([Bit], [Bit])
syndromeRound d zAnc xAnc = do
  zBits <- zRound d zAnc
  xBits <- xRound d xAnc
  return (zBits, xBits)

-- Distance-3 surface-code memory fragment.
surfaceCode :: Circ ([Bit], [Bit], [Bit])
surfaceCode = do
  d    <- mapM (const (qinit False)) [1..9]
  zAnc <- mapM (const (qinit False)) [1..4]
  xAnc <- mapM (const (qinit False)) [1..4]

  d' <- injectX d 4

  (zBits, xBits) <- syndromeRound d' zAnc xAnc

  final <- mapM measure d'
  mapM_ qdiscard zAnc
  mapM_ qdiscard xAnc
  return (zBits, xBits, final)

main :: IO ()
main = print_simple ASCII surfaceCode
