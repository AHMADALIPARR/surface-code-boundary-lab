// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
//
// SurfaceCode dialect (textual MLIR sketch).
// Operations describe stabilizer extraction, logical operators,
// and entropy injection from an external QRNG source.

// Dialect: scode
// Namespace: scode

// %data = scode.alloc_data {distance = 3} : !scode.data
// %anc  = scode.alloc_ancilla {count = 4} : !scode.ancilla
// scode.apply_x %data[4]
// scode.inject_entropy %data {source = "anu_qrng", multiplicity = 2}
// %synd = scode.syndrome_round %data, %anc : !scode.syndrome
// %lz   = scode.logical_z %data : i1
// scode.dealloc %data, %anc

// Types
// !scode.data     - data qubit register
// !scode.ancilla  - ancilla register
// !scode.syndrome - syndrome bit vector

// Attributes
// distance      : i32
// source        : string ("anu_qrng" | "system")
// multiplicity  : i32   (how many QRNG samples to XOR together)
