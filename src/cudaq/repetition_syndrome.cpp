// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

#include <cudaq.h>
#include <iostream>
#include <vector>
#include <string>

// Rotated surface-code stabilizer extraction for a distance-3 patch.
// Data layout (row-major, 3x3):
//   d0  d1  d2
//   d3  d4  d5
//   d6  d7  d8
// Z-ancillas measure the four face plaquettes.
// X-ancillas measure the dual (weight-2/4) checks along the other boundary.
// This kernel is a classical simulation description; it does not claim
// physical QPU execution.

// Apply a single Z-type plaquette check into an ancilla.
__qpu__ void apply_z_face(cudaq::qview<> data, cudaq::qubit& anc,
                          int i0, int i1, int i2, int i3) {
    x<cudaq::ctrl>(data[i0], anc);
    x<cudaq::ctrl>(data[i1], anc);
    x<cudaq::ctrl>(data[i2], anc);
    x<cudaq::ctrl>(data[i3], anc);
}

// Apply a single X-type check (Hadamard sandwich) into an ancilla.
__qpu__ void apply_x_face(cudaq::qview<> data, cudaq::qubit& anc,
                          int i0, int i1, int i2, int i3) {
    h(data[i0]); h(data[i1]); h(data[i2]); h(data[i3]);
    x<cudaq::ctrl>(data[i0], anc);
    x<cudaq::ctrl>(data[i1], anc);
    x<cudaq::ctrl>(data[i2], anc);
    x<cudaq::ctrl>(data[i3], anc);
    h(data[i0]); h(data[i1]); h(data[i2]); h(data[i3]);
}

// Full Z-stabilizer round for the four interior faces.
__qpu__ void measure_z_stabilizers(cudaq::qview<> data, cudaq::qview<> z_anc) {
    apply_z_face(data, z_anc[0], 0, 1, 3, 4);  // top-left
    apply_z_face(data, z_anc[1], 1, 2, 4, 5);  // top-right
    apply_z_face(data, z_anc[2], 3, 4, 6, 7);  // bottom-left
    apply_z_face(data, z_anc[3], 4, 5, 7, 8);  // bottom-right
}

// X-stabilizer round (dual faces). Uses the same four ancilla slots
// after the Z measurement has been recorded and the ancillas reset.
__qpu__ void measure_x_stabilizers(cudaq::qview<> data, cudaq::qview<> x_anc) {
    apply_x_face(data, x_anc[0], 0, 1, 3, 4);
    apply_x_face(data, x_anc[1], 1, 2, 4, 5);
    apply_x_face(data, x_anc[2], 3, 4, 6, 7);
    apply_x_face(data, x_anc[3], 4, 5, 7, 8);
}

// Inject a deterministic Pauli fault for testing.
__qpu__ void inject_fault(cudaq::qview<> data, int qubit, char pauli) {
    if (pauli == 'X' || pauli == 'x') {
        x(data[qubit]);
    } else if (pauli == 'Z' || pauli == 'z') {
        z(data[qubit]);
    } else if (pauli == 'Y' || pauli == 'y') {
        y(data[qubit]);
    }
}

// One full syndrome extraction round: Z then X.
__qpu__ void syndrome_round(cudaq::qview<> data,
                            cudaq::qview<> z_anc,
                            cudaq::qview<> x_anc) {
    measure_z_stabilizers(data, z_anc);
    mz(z_anc);
    // Reset ancillas for the X round (in a real circuit this would be
    // a mid-circuit reset; here we re-initialize by measuring and
    // continuing on a fresh view in the caller).
    measure_x_stabilizers(data, x_anc);
    mz(x_anc);
}

// Multi-round memory experiment entry point.
__qpu__ void surface_code_memory(int rounds) {
    cudaq::qvector data(9);
    cudaq::qvector z_anc(4);
    cudaq::qvector x_anc(4);

    // Optional center-qubit X fault for baseline testing.
    inject_fault(data, 4, 'X');

    for (int r = 0; r < rounds; ++r) {
        syndrome_round(data, z_anc, x_anc);
    }

    // Final data measurement (computational basis) for logical readout.
    mz(data);
}

int main(int argc, char** argv) {
    int rounds = 1;
    if (argc > 1) {
        rounds = std::stoi(argv[1]);
    }
    constexpr int shots = 512;

    std::cout << "CUDA-Q distance-3 rotated surface code\n";
    std::cout << "Data qubits: 9  Z-ancilla: 4  X-ancilla: 4\n";
    std::cout << "Rounds: " << rounds << "  Shots: " << shots << "\n";

    auto counts = cudaq::sample(shots, surface_code_memory, rounds);
    counts.dump();
    return 0;
}
