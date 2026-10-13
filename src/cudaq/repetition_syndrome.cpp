// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

#include <cudaq.h>
#include <iostream>
#include <vector>

// Rotated surface-code Z-stabilizer round for a distance-3 patch.
// Data layout (row-major):
//   d0  d1  d2
//   d3  d4  d5
//   d6  d7  d8
// Ancillas measure the four face stabilizers of the interior 2x2 plaquettes
// plus boundary checks. This is a classical-simulation kernel; it does not
// claim hardware execution.

__qpu__ void measure_z_stabilizers(cudaq::qview<> data, cudaq::qview<> ancilla) {
    // Face 0: Z(d0) Z(d1) Z(d3) Z(d4)
    x<cudaq::ctrl>(data[0], ancilla[0]);
    x<cudaq::ctrl>(data[1], ancilla[0]);
    x<cudaq::ctrl>(data[3], ancilla[0]);
    x<cudaq::ctrl>(data[4], ancilla[0]);

    // Face 1: Z(d1) Z(d2) Z(d4) Z(d5)
    x<cudaq::ctrl>(data[1], ancilla[1]);
    x<cudaq::ctrl>(data[2], ancilla[1]);
    x<cudaq::ctrl>(data[4], ancilla[1]);
    x<cudaq::ctrl>(data[5], ancilla[1]);

    // Face 2: Z(d3) Z(d4) Z(d6) Z(d7)
    x<cudaq::ctrl>(data[3], ancilla[2]);
    x<cudaq::ctrl>(data[4], ancilla[2]);
    x<cudaq::ctrl>(data[6], ancilla[2]);
    x<cudaq::ctrl>(data[7], ancilla[2]);

    // Face 3: Z(d4) Z(d5) Z(d7) Z(d8)
    x<cudaq::ctrl>(data[4], ancilla[3]);
    x<cudaq::ctrl>(data[5], ancilla[3]);
    x<cudaq::ctrl>(data[7], ancilla[3]);
    x<cudaq::ctrl>(data[8], ancilla[3]);
}

__qpu__ void surface_code_round() {
    cudaq::qvector data(9);
    cudaq::qvector ancilla(4);

    // Optional deterministic fault for testing (middle data qubit).
    x(data[4]);

    measure_z_stabilizers(data, ancilla);

    // Measure all ancillas in Z basis.
    mz(ancilla);
}

int main() {
    constexpr int shots = 1024;
    auto counts = cudaq::sample(shots, surface_code_round);
    std::cout << "Distance-3 surface-code Z-stabilizer round (CUDA-Q)\n";
    std::cout << "Data qubits: 9, Ancilla qubits: 4\n";
    counts.dump();
    return 0;
}
