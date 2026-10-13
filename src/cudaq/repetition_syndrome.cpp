// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later. See ../../LICENSE.

#include <cudaq.h>
#include <iostream>
#include <vector>

// Distance-3 rotated surface-code fragment: 4 data + 2 Z-ancilla.
// Layout:
//   d0 -- d1
//   |     |
//   d2 -- d3
__qpu__ void surface_stabilizer_round(cudaq::qview<> data, cudaq::qview<> ancilla) {
    // Z-stabilizer on face 0 (d0, d1, d2)
    x<cudaq::ctrl>(data[0], ancilla[0]);
    x<cudaq::ctrl>(data[1], ancilla[0]);
    x<cudaq::ctrl>(data[2], ancilla[0]);

    // Z-stabilizer on face 1 (d1, d3)
    x<cudaq::ctrl>(data[1], ancilla[1]);
    x<cudaq::ctrl>(data[3], ancilla[1]);
}

__qpu__ void run_surface() {
    cudaq::qvector data(4);
    cudaq::qvector ancilla(2);

    // Deterministic test fault.
    x(data[1]);

    surface_stabilizer_round(data, ancilla);

    mz(ancilla);
}

int main() {
    constexpr int shots = 1024;
    auto counts = cudaq::sample(shots, run_surface);
    std::cout << "Surface-code stabilizer round counts:\n";
    counts.dump();
    return 0;
}
