// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

namespace SurfaceCodeBoundaryLab {
    // Distance-3 rotated surface-code Z-stabilizer round.
    // Data layout (row-major):
    //   d0 d1 d2
    //   d3 d4 d5
    //   d6 d7 d8
    // Four ancillas measure the four face stabilizers.

    operation MeasureZStabilizers(data : Qubit[], ancilla : Qubit[]) : Unit {
        // Face 0: Z(d0) Z(d1) Z(d3) Z(d4)
        CNOT(data[0], ancilla[0]);
        CNOT(data[1], ancilla[0]);
        CNOT(data[3], ancilla[0]);
        CNOT(data[4], ancilla[0]);

        // Face 1: Z(d1) Z(d2) Z(d4) Z(d5)
        CNOT(data[1], ancilla[1]);
        CNOT(data[2], ancilla[1]);
        CNOT(data[4], ancilla[1]);
        CNOT(data[5], ancilla[1]);

        // Face 2: Z(d3) Z(d4) Z(d6) Z(d7)
        CNOT(data[3], ancilla[2]);
        CNOT(data[4], ancilla[2]);
        CNOT(data[6], ancilla[2]);
        CNOT(data[7], ancilla[2]);

        // Face 3: Z(d4) Z(d5) Z(d7) Z(d8)
        CNOT(data[4], ancilla[3]);
        CNOT(data[5], ancilla[3]);
        CNOT(data[7], ancilla[3]);
        CNOT(data[8], ancilla[3]);
    }

    @EntryPoint()
    operation Main() : Result[] {
        use data = Qubit[9];
        use ancilla = Qubit[4];

        // Optional deterministic fault on the center data qubit.
        X(data[4]);

        MeasureZStabilizers(data, ancilla);

        let results = MeasureEachZ(ancilla);
        ResetAll(data);
        ResetAll(ancilla);
        return results;
    }
}
