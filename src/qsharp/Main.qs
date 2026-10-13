// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

namespace SurfaceCodeBoundaryLab {
    // Small rotated surface-code style stabilizer round (distance-3 fragment).
    // Measures a 2x2 patch of Z-stabilizers on data qubits arranged as:
    //   d0 d1
    //   d2 d3
    // with two ancillas for the two face stabilizers.
    @EntryPoint()
    operation Main() : (Result, Result) {
        use data = Qubit[4];
        use ancilla = Qubit[2];

        let d0 = data[0];
        let d1 = data[1];
        let d2 = data[2];
        let d3 = data[3];
        let a0 = ancilla[0];
        let a1 = ancilla[1];

        // Optional deterministic fault for testing.
        X(d1);

        // Z-stabilizer round (face checks).
        // a0 measures Z(d0)Z(d1)Z(d2)
        CNOT(d0, a0);
        CNOT(d1, a0);
        CNOT(d2, a0);

        // a1 measures Z(d1)Z(d3)
        CNOT(d1, a1);
        CNOT(d3, a1);

        let s0 = M(a0);
        let s1 = M(a1);

        ResetAll(data);
        ResetAll(ancilla);
        return (s0, s1);
    }
}
