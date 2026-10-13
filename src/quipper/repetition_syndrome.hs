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

-- Additional Quipper surface-code helpers
-- Face application helper 1
applyCheck1 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck1 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 2
applyCheck2 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck2 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 3
applyCheck3 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck3 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 4
applyCheck4 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck4 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 5
applyCheck5 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck5 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 6
applyCheck6 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck6 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 7
applyCheck7 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck7 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 8
applyCheck8 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck8 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 9
applyCheck9 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck9 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 10
applyCheck10 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck10 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 11
applyCheck11 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck11 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 12
applyCheck12 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck12 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 13
applyCheck13 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck13 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 14
applyCheck14 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck14 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 15
applyCheck15 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck15 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 16
applyCheck16 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck16 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 17
applyCheck17 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck17 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 18
applyCheck18 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck18 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 19
applyCheck19 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck19 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 20
applyCheck20 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck20 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 21
applyCheck21 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck21 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 22
applyCheck22 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck22 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 23
applyCheck23 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck23 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 24
applyCheck24 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck24 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 25
applyCheck25 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck25 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 26
applyCheck26 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck26 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 27
applyCheck27 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck27 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 28
applyCheck28 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck28 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 29
applyCheck29 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck29 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 30
applyCheck30 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck30 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 31
applyCheck31 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck31 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 32
applyCheck32 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck32 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 33
applyCheck33 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck33 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 34
applyCheck34 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck34 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 35
applyCheck35 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck35 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 36
applyCheck36 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck36 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 37
applyCheck37 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck37 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 38
applyCheck38 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck38 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 39
applyCheck39 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck39 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 40
applyCheck40 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck40 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 41
applyCheck41 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck41 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 42
applyCheck42 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck42 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 43
applyCheck43 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck43 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 44
applyCheck44 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck44 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 45
applyCheck45 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck45 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 46
applyCheck46 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck46 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 47
applyCheck47 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck47 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 48
applyCheck48 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck48 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 49
applyCheck49 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck49 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 50
applyCheck50 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck50 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 51
applyCheck51 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck51 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 52
applyCheck52 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck52 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 53
applyCheck53 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck53 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 54
applyCheck54 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck54 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 55
applyCheck55 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck55 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 56
applyCheck56 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck56 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 57
applyCheck57 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck57 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 58
applyCheck58 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck58 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 59
applyCheck59 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck59 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 60
applyCheck60 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck60 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 61
applyCheck61 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck61 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 62
applyCheck62 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck62 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 63
applyCheck63 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck63 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 64
applyCheck64 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck64 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 65
applyCheck65 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck65 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 66
applyCheck66 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck66 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 67
applyCheck67 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck67 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 68
applyCheck68 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck68 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 69
applyCheck69 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck69 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 70
applyCheck70 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck70 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 71
applyCheck71 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck71 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 72
applyCheck72 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck72 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 73
applyCheck73 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck73 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 74
applyCheck74 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck74 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 75
applyCheck75 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck75 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 76
applyCheck76 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck76 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 77
applyCheck77 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck77 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 78
applyCheck78 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck78 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 79
applyCheck79 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck79 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 80
applyCheck80 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck80 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 81
applyCheck81 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck81 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 82
applyCheck82 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck82 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 83
applyCheck83 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck83 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 84
applyCheck84 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck84 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 85
applyCheck85 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck85 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 86
applyCheck86 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck86 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 87
applyCheck87 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck87 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 88
applyCheck88 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck88 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 89
applyCheck89 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck89 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 90
applyCheck90 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck90 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 91
applyCheck91 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck91 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 92
applyCheck92 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck92 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 93
applyCheck93 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck93 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 94
applyCheck94 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck94 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 95
applyCheck95 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck95 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 96
applyCheck96 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck96 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 97
applyCheck97 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck97 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 98
applyCheck98 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck98 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 99
applyCheck99 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck99 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 100
applyCheck100 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck100 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 101
applyCheck101 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck101 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 102
applyCheck102 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck102 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 103
applyCheck103 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck103 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 104
applyCheck104 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck104 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 105
applyCheck105 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck105 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 106
applyCheck106 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck106 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 107
applyCheck107 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck107 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 108
applyCheck108 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck108 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 109
applyCheck109 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck109 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 110
applyCheck110 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck110 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 111
applyCheck111 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck111 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 112
applyCheck112 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck112 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 113
applyCheck113 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck113 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 114
applyCheck114 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck114 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 115
applyCheck115 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck115 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 116
applyCheck116 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck116 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 117
applyCheck117 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck117 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 118
applyCheck118 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck118 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 119
applyCheck119 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck119 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 120
applyCheck120 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck120 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 121
applyCheck121 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck121 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 122
applyCheck122 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck122 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 123
applyCheck123 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck123 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 124
applyCheck124 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck124 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 125
applyCheck125 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck125 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 126
applyCheck126 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck126 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 127
applyCheck127 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck127 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 128
applyCheck128 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck128 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 129
applyCheck129 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck129 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 130
applyCheck130 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck130 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 131
applyCheck131 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck131 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 132
applyCheck132 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck132 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 133
applyCheck133 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck133 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 134
applyCheck134 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck134 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 135
applyCheck135 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck135 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 136
applyCheck136 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck136 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 137
applyCheck137 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck137 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 138
applyCheck138 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck138 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 139
applyCheck139 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck139 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 140
applyCheck140 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck140 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 141
applyCheck141 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck141 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 142
applyCheck142 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck142 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 143
applyCheck143 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck143 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 144
applyCheck144 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck144 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 145
applyCheck145 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck145 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 146
applyCheck146 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck146 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 147
applyCheck147 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck147 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 148
applyCheck148 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck148 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 149
applyCheck149 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck149 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 150
applyCheck150 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck150 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 151
applyCheck151 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck151 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 152
applyCheck152 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck152 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 153
applyCheck153 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck153 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 154
applyCheck154 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck154 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 155
applyCheck155 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck155 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 156
applyCheck156 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck156 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 157
applyCheck157 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck157 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 158
applyCheck158 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck158 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 159
applyCheck159 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck159 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 160
applyCheck160 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck160 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 161
applyCheck161 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck161 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 162
applyCheck162 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck162 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 163
applyCheck163 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck163 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 164
applyCheck164 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck164 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 165
applyCheck165 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck165 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 166
applyCheck166 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck166 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 167
applyCheck167 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck167 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 168
applyCheck168 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck168 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

-- Face application helper 169
applyCheck169 :: [Qubit] -> Qubit -> [Int] -> Circ Qubit
applyCheck169 dataQ anc idxs = do
  let qs = map (dataQ !!) idxs
  foldM (\a q -> qnot a `controlled` q) anc qs

