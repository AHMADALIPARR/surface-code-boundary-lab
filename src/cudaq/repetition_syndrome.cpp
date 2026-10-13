// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

#include <cudaq.h>
#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>

// Distance-3 rotated surface code stabilizer extraction.
// Data layout (row-major 3x3):
//   d0  d1  d2
//   d3  d4  d5
//   d6  d7  d8
// Four Z-face ancillas and four X-face ancillas.
// Boundary weight-2 checks are included for the rough/smooth edges.
// Classical simulation only; does not claim physical QPU execution.

struct Face {
    int qubits[4];
    int count;
};

static const Face Z_FACES[4] = {
    {{0, 1, 3, 4}, 4},
    {{1, 2, 4, 5}, 4},
    {{3, 4, 6, 7}, 4},
    {{4, 5, 7, 8}, 4}
};

static const Face X_FACES[4] = {
    {{0, 1, 3, 4}, 4},
    {{1, 2, 4, 5}, 4},
    {{3, 4, 6, 7}, 4},
    {{4, 5, 7, 8}, 4}
};

// Weight-2 boundary checks (smooth for Z, rough for X).
static const Face Z_BOUNDARY[4] = {
    {{0, 1}, 2}, {{1, 2}, 2}, {{6, 7}, 2}, {{7, 8}, 2}
};

static const Face X_BOUNDARY[4] = {
    {{0, 3}, 2}, {{3, 6}, 2}, {{2, 5}, 2}, {{5, 8}, 2}
};

__qpu__ void apply_controlled_x(cudaq::qview<> data, cudaq::qubit& anc, int idx) {
    x<cudaq::ctrl>(data[idx], anc);
}

__qpu__ void apply_z_face(cudaq::qview<> data, cudaq::qubit& anc, const Face& face) {
    for (int k = 0; k < face.count; ++k) {
        apply_controlled_x(data, anc, face.qubits[k]);
    }
}

__qpu__ void apply_x_face(cudaq::qview<> data, cudaq::qubit& anc, const Face& face) {
    for (int k = 0; k < face.count; ++k) {
        h(data[face.qubits[k]]);
    }
    for (int k = 0; k < face.count; ++k) {
        apply_controlled_x(data, anc, face.qubits[k]);
    }
    for (int k = 0; k < face.count; ++k) {
        h(data[face.qubits[k]]);
    }
}

__qpu__ void measure_z_bulk(cudaq::qview<> data, cudaq::qview<> anc) {
    apply_z_face(data, anc[0], Z_FACES[0]);
    apply_z_face(data, anc[1], Z_FACES[1]);
    apply_z_face(data, anc[2], Z_FACES[2]);
    apply_z_face(data, anc[3], Z_FACES[3]);
}

__qpu__ void measure_x_bulk(cudaq::qview<> data, cudaq::qview<> anc) {
    apply_x_face(data, anc[0], X_FACES[0]);
    apply_x_face(data, anc[1], X_FACES[1]);
    apply_x_face(data, anc[2], X_FACES[2]);
    apply_x_face(data, anc[3], X_FACES[3]);
}

__qpu__ void measure_z_boundary(cudaq::qview<> data, cudaq::qview<> anc) {
    apply_z_face(data, anc[0], Z_BOUNDARY[0]);
    apply_z_face(data, anc[1], Z_BOUNDARY[1]);
    apply_z_face(data, anc[2], Z_BOUNDARY[2]);
    apply_z_face(data, anc[3], Z_BOUNDARY[3]);
}

__qpu__ void measure_x_boundary(cudaq::qview<> data, cudaq::qview<> anc) {
    apply_x_face(data, anc[0], X_BOUNDARY[0]);
    apply_x_face(data, anc[1], X_BOUNDARY[1]);
    apply_x_face(data, anc[2], X_BOUNDARY[2]);
    apply_x_face(data, anc[3], X_BOUNDARY[3]);
}

__qpu__ void inject_pauli(cudaq::qview<> data, int q, char p) {
    if (p == 'X' || p == 'x') x(data[q]);
    else if (p == 'Z' || p == 'z') z(data[q]);
    else if (p == 'Y' || p == 'y') y(data[q]);
}

__qpu__ void depolarize_data(cudaq::qview<> data, double p) {
    // Placeholder: real noise is applied by the Stim factory or by
    // CUDA-Q noise models outside this pure kernel.
    (void)p;
}

__qpu__ void syndrome_round(cudaq::qview<> data,
                            cudaq::qview<> z_bulk,
                            cudaq::qview<> x_bulk,
                            cudaq::qview<> z_bound,
                            cudaq::qview<> x_bound) {
    measure_z_bulk(data, z_bulk);
    mz(z_bulk);
    measure_x_bulk(data, x_bulk);
    mz(x_bulk);
    measure_z_boundary(data, z_bound);
    mz(z_bound);
    measure_x_boundary(data, x_bound);
    mz(x_bound);
}

__qpu__ void surface_memory(int rounds, int fault_qubit, char fault_pauli) {
    cudaq::qvector data(9);
    cudaq::qvector z_bulk(4);
    cudaq::qvector x_bulk(4);
    cudaq::qvector z_bound(4);
    cudaq::qvector x_bound(4);

    if (fault_qubit >= 0 && fault_qubit < 9) {
        inject_pauli(data, fault_qubit, fault_pauli);
    }

    for (int r = 0; r < rounds; ++r) {
        syndrome_round(data, z_bulk, x_bulk, z_bound, x_bound);
    }
    mz(data);
}

int main(int argc, char** argv) {
    int rounds = 3;
    int fault_q = 4;
    char fault_p = 'X';
    if (argc > 1) rounds = std::atoi(argv[1]);
    if (argc > 2) fault_q = std::atoi(argv[2]);
    if (argc > 3) fault_p = argv[3][0];

    constexpr int shots = 256;
    std::cout << "CUDA-Q d=3 rotated surface code\n";
    std::cout << "Data=9  Z-bulk=4  X-bulk=4  Z-bound=4  X-bound=4\n";
    std::cout << "Rounds=" << rounds
              << "  Fault qubit=" << fault_q
              << "  Pauli=" << fault_p
              << "  Shots=" << shots << "\n";

    auto counts = cudaq::sample(shots, surface_memory, rounds, fault_q, fault_p);
    counts.dump();
    return 0;
}
