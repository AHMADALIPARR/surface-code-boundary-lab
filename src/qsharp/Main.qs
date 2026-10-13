// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

namespace SurfaceCodeBoundaryLab {
    // Distance-3 rotated surface-code stabilizer extraction.
    // Data layout (row-major):
    //   d0 d1 d2
    //   d3 d4 d5
    //   d6 d7 d8
    // Z-ancillas and X-ancillas each measure the four face stabilizers.

    operation ApplyZFace(data : Qubit[], anc : Qubit, i0 : Int, i1 : Int, i2 : Int, i3 : Int) : Unit {
        CNOT(data[i0], anc);
        CNOT(data[i1], anc);
        CNOT(data[i2], anc);
        CNOT(data[i3], anc);
    }

    operation ApplyXFace(data : Qubit[], anc : Qubit, i0 : Int, i1 : Int, i2 : Int, i3 : Int) : Unit {
        H(data[i0]); H(data[i1]); H(data[i2]); H(data[i3]);
        CNOT(data[i0], anc);
        CNOT(data[i1], anc);
        CNOT(data[i2], anc);
        CNOT(data[i3], anc);
        H(data[i0]); H(data[i1]); H(data[i2]); H(data[i3]);
    }

    operation MeasureZStabilizers(data : Qubit[], zAnc : Qubit[]) : Unit {
        ApplyZFace(data, zAnc[0], 0, 1, 3, 4);
        ApplyZFace(data, zAnc[1], 1, 2, 4, 5);
        ApplyZFace(data, zAnc[2], 3, 4, 6, 7);
        ApplyZFace(data, zAnc[3], 4, 5, 7, 8);
    }

    operation MeasureXStabilizers(data : Qubit[], xAnc : Qubit[]) : Unit {
        ApplyXFace(data, xAnc[0], 0, 1, 3, 4);
        ApplyXFace(data, xAnc[1], 1, 2, 4, 5);
        ApplyXFace(data, xAnc[2], 3, 4, 6, 7);
        ApplyXFace(data, xAnc[3], 4, 5, 7, 8);
    }

    operation InjectFault(data : Qubit[], index : Int, pauli : Pauli) : Unit {
        if pauli == PauliX {
            X(data[index]);
        } elif pauli == PauliZ {
            Z(data[index]);
        } elif pauli == PauliY {
            Y(data[index]);
        }
    }

    operation SyndromeRound(data : Qubit[], zAnc : Qubit[], xAnc : Qubit[]) : (Result[], Result[]) {
        MeasureZStabilizers(data, zAnc);
        let zResults = MeasureEachZ(zAnc);
        ResetAll(zAnc);

        MeasureXStabilizers(data, xAnc);
        let xResults = MeasureEachZ(xAnc);
        ResetAll(xAnc);

        return (zResults, xResults);
    }

    operation RunMemory(rounds : Int) : (Result[][], Result[][], Result[]) {
        use data = Qubit[9];
        use zAnc = Qubit[4];
        use xAnc = Qubit[4];

        // Baseline deterministic fault on the center data qubit.
        InjectFault(data, 4, PauliX);

        mutable zHistory = [];
        mutable xHistory = [];
        for _ in 1..rounds {
            let (zRes, xRes) = SyndromeRound(data, zAnc, xAnc);
            set zHistory += [zRes];
            set xHistory += [xRes];
        }

        let finalData = MeasureEachZ(data);
        ResetAll(data);
        return (zHistory, xHistory, finalData);
    }

    @EntryPoint()
    operation Main() : (Result[][], Result[][], Result[]) {
        return RunMemory(1);
    }
}
