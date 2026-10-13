-- SPDX-License-Identifier: AGPL-3.0-or-later
import Control.Monad (foldM)
-- Copyright (C) 2026 SnapKitty Collective
-- Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

-- Quipper distance-3 rotated surface code with bulk faces and boundary checks.
-- 9 data + 4 Z-bulk + 4 X-bulk + 4 Z-boundary + 4 X-boundary ancillas.
-- Verify API against the installed Quipper version.

module Main where

import Quipper

type Face = [Int]

zFaces :: [Face]
zFaces = [[0,1,3,4], [1,2,4,5], [3,4,6,7], [4,5,7,8]]

xFaces :: [Face]
xFaces = [[0,1,3,4], [1,2,4,5], [3,4,6,7], [4,5,7,8]]

zBoundary :: [Face]
zBoundary = [[0,1], [1,2], [6,7], [7,8]]

xBoundary :: [Face]
xBoundary = [[0,3], [3,6], [2,5], [5,8]]

applyFace :: Bool -> [Qubit] -> Qubit -> Face -> Circ Qubit
applyFace isX dataQ anc face = do
  let qs = map (dataQ !!) face
  qs' <- if isX then mapM hadamard qs else return qs
  anc' <- foldM (\a q -> qnot a `controlled` q) anc qs'
  _ <- if isX then mapM hadamard qs' else return qs'
  return anc'

zBulkRound :: [Qubit] -> [Qubit] -> Circ [Bit]
zBulkRound d anc = do
  a0 <- applyFace False d (anc !! 0) (zFaces !! 0)
  a1 <- applyFace False d (anc !! 1) (zFaces !! 1)
  a2 <- applyFace False d (anc !! 2) (zFaces !! 2)
  a3 <- applyFace False d (anc !! 3) (zFaces !! 3)
  mapM measure [a0, a1, a2, a3]

xBulkRound :: [Qubit] -> [Qubit] -> Circ [Bit]
xBulkRound d anc = do
  a0 <- applyFace True d (anc !! 0) (xFaces !! 0)
  a1 <- applyFace True d (anc !! 1) (xFaces !! 1)
  a2 <- applyFace True d (anc !! 2) (xFaces !! 2)
  a3 <- applyFace True d (anc !! 3) (xFaces !! 3)
  mapM measure [a0, a1, a2, a3]

zBoundRound :: [Qubit] -> [Qubit] -> Circ [Bit]
zBoundRound d anc = do
  a0 <- applyFace False d (anc !! 0) (zBoundary !! 0)
  a1 <- applyFace False d (anc !! 1) (zBoundary !! 1)
  a2 <- applyFace False d (anc !! 2) (zBoundary !! 2)
  a3 <- applyFace False d (anc !! 3) (zBoundary !! 3)
  mapM measure [a0, a1, a2, a3]

xBoundRound :: [Qubit] -> [Qubit] -> Circ [Bit]
xBoundRound d anc = do
  a0 <- applyFace True d (anc !! 0) (xBoundary !! 0)
  a1 <- applyFace True d (anc !! 1) (xBoundary !! 1)
  a2 <- applyFace True d (anc !! 2) (xBoundary !! 2)
  a3 <- applyFace True d (anc !! 3) (xBoundary !! 3)
  mapM measure [a0, a1, a2, a3]

injectX :: [Qubit] -> Int -> Circ [Qubit]
injectX qs i = do
  let (pre, q:post) = splitAt i qs
  q' <- qnot q
  return (pre ++ q' : post)

syndromeRound :: [Qubit] -> [Qubit] -> [Qubit] -> [Qubit] -> [Qubit]
              -> Circ ([Bit], [Bit], [Bit], [Bit])
syndromeRound d zb xb zbd xbd = do
  zbBits  <- zBulkRound d zb
  xbBits  <- xBulkRound d xb
  zbdBits <- zBoundRound d zbd
  xbdBits <- xBoundRound d xbd
  return (zbBits, xbBits, zbdBits, xbdBits)

surfaceCode :: Circ ([Bit], [Bit], [Bit], [Bit], [Bit])
surfaceCode = do
  d    <- mapM (const (qinit False)) [1..9]
  zb   <- mapM (const (qinit False)) [1..4]
  xb   <- mapM (const (qinit False)) [1..4]
  zbd  <- mapM (const (qinit False)) [1..4]
  xbd  <- mapM (const (qinit False)) [1..4]

  d' <- injectX d 4
  (zbB, xbB, zbdB, xbdB) <- syndromeRound d' zb xb zbd xbd
  final <- mapM measure d'

  mapM_ qdiscard zb
  mapM_ qdiscard xb
  mapM_ qdiscard zbd
  mapM_ qdiscard xbd
  return (zbB, xbB, zbdB, xbdB, final)

main :: IO ()
main = print_simple ASCII surfaceCode

-- Additional helpers for multi-round extraction and logical operators.

-- Repeat a syndrome round n times, collecting bits.
multiRound :: Int -> [Qubit] -> [Qubit] -> [Qubit] -> [Qubit] -> [Qubit]
           -> Circ [([Bit], [Bit], [Bit], [Bit])]
multiRound 0 _ _ _ _ _ = return []
multiRound n d zb xb zbd xbd = do
  bits <- syndromeRound d zb xb zbd xbd
  rest <- multiRound (n-1) d zb xb zbd xbd
  return (bits : rest)

-- Logical Z operator on the first row (weight-3).
logicalZ :: [Qubit] -> Circ [Qubit]
logicalZ d = do
  d0 <- zGate (d !! 0)
  d1 <- zGate (d !! 1)
  d2 <- zGate (d !! 2)
  return (d0 : d1 : d2 : drop 3 d)

-- Logical X operator on the first column (weight-3).
logicalX :: [Qubit] -> Circ [Qubit]
logicalX d = do
  d0 <- xGate (d !! 0)
  d3 <- xGate (d !! 3)
  d6 <- xGate (d !! 6)
  return (d0 : take 2 (drop 1 d) ++ [d3] ++ take 2 (drop 4 d) ++ [d6] ++ drop 7 d)

-- Placeholder gates (Quipper provides these; names may vary by version).
zGate :: Qubit -> Circ Qubit
zGate q = do
  q <- hadamard q
  q <- qnot q
  q <- hadamard q
  return q

xGate :: Qubit -> Circ Qubit
xGate q = qnot q

-- Entry that runs three rounds and prints the circuit.
surfaceCodeMulti :: Circ [([Bit], [Bit], [Bit], [Bit])]
surfaceCodeMulti = do
  d   <- mapM (const (qinit False)) [1..9]
  zb  <- mapM (const (qinit False)) [1..4]
  xb  <- mapM (const (qinit False)) [1..4]
  zbd <- mapM (const (qinit False)) [1..4]
  xbd <- mapM (const (qinit False)) [1..4]
  d'  <- injectX d 4
  hist <- multiRound 3 d' zb xb zbd xbd
  mapM_ qdiscard (d' ++ zb ++ xb ++ zbd ++ xbd)
  return hist
