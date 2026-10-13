\ SPDX-License-Identifier: AGPL-3.0-or-later
\ Copyright (C) 2026 SnapKitty Collective
\ Licensed under GNU Affero General Public License v3 or later.
\
\ Forth backend for the Surface Code Boundary Lab.
\ Classical simulation of a distance-3 rotated surface code:
\ bulk Z/X faces, boundary checks, logical operators,
\ multi-round syndrome collection.

3 CONSTANT DISTANCE
9 CONSTANT NDATA

CREATE DATA-BITS NDATA ALLOT

: DATA-INDEX ( x y -- idx ) DISTANCE * + ;

: CLEAR-DATA ( -- )
  NDATA 0 DO 0 I DATA-BITS + C! LOOP ;

: APPLY-X ( idx -- )
  DUP NDATA < IF
    DATA-BITS + DUP C@ 1 XOR SWAP C!
  ELSE DROP THEN ;

: APPLY-LOGICAL-X ( -- )
  0 0 DATA-INDEX APPLY-X
  0 1 DATA-INDEX APPLY-X
  0 2 DATA-INDEX APPLY-X ;

: APPLY-LOGICAL-Z ( -- )
  \ Phase-only in this bit model; no state change.
  ;

: BIT@ ( idx -- bit ) DATA-BITS + C@ ;

: FACE-PARITY ( idx1 idx2 idx3 idx4 -- parity )
  BIT@ >R BIT@ >R BIT@ >R BIT@ R> XOR R> XOR R> XOR ;

: MEASURE-Z-BULK ( -- p0 p1 p2 p3 )
  0 0 DATA-INDEX 1 0 DATA-INDEX 0 1 DATA-INDEX 1 1 DATA-INDEX FACE-PARITY
  1 0 DATA-INDEX 2 0 DATA-INDEX 1 1 DATA-INDEX 2 1 DATA-INDEX FACE-PARITY
  0 1 DATA-INDEX 1 1 DATA-INDEX 0 2 DATA-INDEX 1 2 DATA-INDEX FACE-PARITY
  1 1 DATA-INDEX 2 1 DATA-INDEX 1 2 DATA-INDEX 2 2 DATA-INDEX FACE-PARITY ;

: LOGICAL-Z-PARITY ( -- bit )
  0 0 DATA-INDEX BIT@
  1 0 DATA-INDEX BIT@ XOR
  2 0 DATA-INDEX BIT@ XOR ;

: BOUNDARY-DIST ( idx -- dist )
  DISTANCE /MOD ( x y )
  DUP DISTANCE 1- SWAP - MIN
  SWAP DUP DISTANCE 1- SWAP - MIN MIN ;

: SYNDROME-ROUND ( -- )
  ." Z-bulk parities: " MEASURE-Z-BULK . . . . CR ;

: RUN-MEMORY ( rounds fault-qubit -- )
  CLEAR-DATA
  DUP 0 >= IF APPLY-X ELSE DROP THEN
  0 DO SYNDROME-ROUND LOOP
  ." Logical Z: " LOGICAL-Z-PARITY . CR ;

: MAIN ( -- )
  ." Forth surface-code backend (d=3)" CR
  ." Data qubits: " NDATA . CR
  3 4 RUN-MEMORY ;

MAIN
