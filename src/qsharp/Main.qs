// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

namespace SurfaceCodeBoundaryLab {
    // Distance-3 rotated surface code with bulk faces and boundary checks.
    // Data layout:
    //   d0 d1 d2
    //   d3 d4 d5
    //   d6 d7 d8

    operation ApplyZFace(data : Qubit[], anc : Qubit, indices : Int[]) : Unit {
        for idx in indices {
            CNOT(data[idx], anc);
        }
    }

    operation ApplyXFace(data : Qubit[], anc : Qubit, indices : Int[]) : Unit {
        for idx in indices {
            H(data[idx]);
        }
        for idx in indices {
            CNOT(data[idx], anc);
        }
        for idx in indices {
            H(data[idx]);
        }
    }

    operation MeasureZBulk(data : Qubit[], anc : Qubit[]) : Unit {
        ApplyZFace(data, anc[0], [0, 1, 3, 4]);
        ApplyZFace(data, anc[1], [1, 2, 4, 5]);
        ApplyZFace(data, anc[2], [3, 4, 6, 7]);
        ApplyZFace(data, anc[3], [4, 5, 7, 8]);
    }

    operation MeasureXBulk(data : Qubit[], anc : Qubit[]) : Unit {
        ApplyXFace(data, anc[0], [0, 1, 3, 4]);
        ApplyXFace(data, anc[1], [1, 2, 4, 5]);
        ApplyXFace(data, anc[2], [3, 4, 6, 7]);
        ApplyXFace(data, anc[3], [4, 5, 7, 8]);
    }

    operation MeasureZBoundary(data : Qubit[], anc : Qubit[]) : Unit {
        ApplyZFace(data, anc[0], [0, 1]);
        ApplyZFace(data, anc[1], [1, 2]);
        ApplyZFace(data, anc[2], [6, 7]);
        ApplyZFace(data, anc[3], [7, 8]);
    }

    operation MeasureXBoundary(data : Qubit[], anc : Qubit[]) : Unit {
        ApplyXFace(data, anc[0], [0, 3]);
        ApplyXFace(data, anc[1], [3, 6]);
        ApplyXFace(data, anc[2], [2, 5]);
        ApplyXFace(data, anc[3], [5, 8]);
    }

    operation InjectPauli(data : Qubit[], index : Int, p : Pauli) : Unit {
        if p == PauliX { X(data[index]); }
        elif p == PauliZ { Z(data[index]); }
        elif p == PauliY { Y(data[index]); }
    }

    operation SyndromeRound(
        data : Qubit[],
        zBulk : Qubit[],
        xBulk : Qubit[],
        zBound : Qubit[],
        xBound : Qubit[]
    ) : (Result[], Result[], Result[], Result[]) {
        MeasureZBulk(data, zBulk);
        let zb = MeasureEachZ(zBulk);
        ResetAll(zBulk);

        MeasureXBulk(data, xBulk);
        let xb = MeasureEachZ(xBulk);
        ResetAll(xBulk);

        MeasureZBoundary(data, zBound);
        let zbd = MeasureEachZ(zBound);
        ResetAll(zBound);

        MeasureXBoundary(data, xBound);
        let xbd = MeasureEachZ(xBound);
        ResetAll(xBound);

        return (zb, xb, zbd, xbd);
    }

    operation RunMemory(rounds : Int, faultQubit : Int, faultPauli : Pauli)
        : (Result[][], Result[][], Result[][], Result[][], Result[]) {
        use data = Qubit[9];
        use zBulk = Qubit[4];
        use xBulk = Qubit[4];
        use zBound = Qubit[4];
        use xBound = Qubit[4];

        if faultQubit >= 0 and faultQubit < 9 {
            InjectPauli(data, faultQubit, faultPauli);
        }

        mutable zbHist = [];
        mutable xbHist = [];
        mutable zbdHist = [];
        mutable xbdHist = [];

        for _ in 1..rounds {
            let (zb, xb, zbd, xbd) = SyndromeRound(data, zBulk, xBulk, zBound, xBound);
            set zbHist += [zb];
            set xbHist += [xb];
            set zbdHist += [zbd];
            set xbdHist += [xbd];
        }

        let finalData = MeasureEachZ(data);
        ResetAll(data);
        return (zbHist, xbHist, zbdHist, xbdHist, finalData);
    }

    @EntryPoint()
    operation Main() : (Result[][], Result[][], Result[][], Result[][], Result[]) {
        return RunMemory(3, 4, PauliX);
    }
}

    operation ApplyLogicalZ(data : Qubit[]) : Unit {
        Z(data[0]); Z(data[1]); Z(data[2]);
    }

    operation ApplyLogicalX(data : Qubit[]) : Unit {
        X(data[0]); X(data[3]); X(data[6]);
    }

    operation Parity(results : Result[]) : Result {
        mutable p = Zero;
        for r in results {
            if r == One { set p = p == Zero ? One | Zero; }
        }
        return p;
    }

    operation RunWithLogical(rounds : Int) : Result {
        use data = Qubit[9];
        ApplyLogicalZ(data);
        let (_, _, _, _, final) = RunMemory(rounds, -1, PauliI);
        return Parity(final);
    }

    // --- Additional functionality ---

    operation ApplyLogicalZ(data : Qubit[]) : Unit {
        // Weight-d logical Z on the first row (d=3).
        Z(data[0]);
        Z(data[1]);
        Z(data[2]);
    }

    operation ApplyLogicalX(data : Qubit[]) : Unit {
        // Weight-d logical X on the first column (d=3).
        X(data[0]);
        X(data[3]);
        X(data[6]);
    }

    operation InjectDepolarizing(data : Qubit[], p : Double) : Unit {
        // Classical placeholder: apply X with probability p on each data qubit.
        // Real noise models belong in the Stim factory or a noise channel.
        for i in 0..Length(data)-1 {
            if RandomReal(1.0) < p {
                X(data[i]);
            }
        }
    }

    operation SyndromeRoundFull(
        data : Qubit[],
        zBulk : Qubit[],
        xBulk : Qubit[],
        zBound : Qubit[],
        xBound : Qubit[]
    ) : (Result[], Result[], Result[], Result[]) {
        MeasureZBulk(data, zBulk);
        let zb = MeasureEachZ(zBulk);
        ResetAll(zBulk);

        MeasureXBulk(data, xBulk);
        let xb = MeasureEachZ(xBulk);
        ResetAll(xBulk);

        MeasureZBoundary(data, zBound);
        let zbd = MeasureEachZ(zBound);
        ResetAll(zBound);

        MeasureXBoundary(data, xBound);
        let xbd = MeasureEachZ(xBound);
        ResetAll(xBound);

        return (zb, xb, zbd, xbd);
    }

    operation RunMemoryExperiment(rounds : Int, faultQubit : Int, pNoise : Double)
        : (Result[][], Result[][], Result[][], Result[][], Result[]) {
        use data = Qubit[9];
        use zBulk = Qubit[4];
        use xBulk = Qubit[4];
        use zBound = Qubit[4];
        use xBound = Qubit[4];

        if faultQubit >= 0 and faultQubit < 9 {
            X(data[faultQubit]);
        }
        InjectDepolarizing(data, pNoise);

        mutable zbH = [];
        mutable xbH = [];
        mutable zbdH = [];
        mutable xbdH = [];

        for _ in 1..rounds {
            let (zb, xb, zbd, xbd) = SyndromeRoundFull(data, zBulk, xBulk, zBound, xBound);
            set zbH += [zb];
            set xbH += [xb];
            set zbdH += [zbd];
            set xbdH += [xbd];
        }

        let finalData = MeasureEachZ(data);
        ResetAll(data);
        return (zbH, xbH, zbdH, xbdH, finalData);
    }

    operation LogicalZParity(results : Result[]) : Result {
        // Parity of the first row (indices 0,1,2) as a logical Z readout.
        mutable p = Zero;
        for i in [0, 1, 2] {
            if results[i] == One {
                set p = p == Zero ? One | Zero;
            }
        }
        return p;
    }

    @EntryPoint()
    operation RunAtlas() : Result {
        let (_, _, _, _, final) = RunMemoryExperiment(3, 4, 0.001);
        return LogicalZParity(final);
    }
}
