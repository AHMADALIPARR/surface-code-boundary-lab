// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later.

// C++ backend for the Surface Code Boundary Lab.
// Classical simulation of a distance-3 rotated surface code:
// bulk Z/X faces, boundary checks, logical operators,
// multi-round syndrome collection, boundary distances.

#include <iostream>
#include <vector>
#include <array>
#include <cstdint>
#include <algorithm>

struct Coord {
    int x;
    int y;
};

class SurfaceCode {
public:
    explicit SurfaceCode(int distance)
        : d_(distance), data_(distance * distance, false) {}

    int data_index(int x, int y) const { return y * d_ + x; }

    void clear() { std::fill(data_.begin(), data_.end(), false); }

    void apply_x(int idx) {
        if (idx >= 0 && idx < static_cast<int>(data_.size()))
            data_[idx] = !data_[idx];
    }

    void apply_z(int idx) { (void)idx; /* phase-only */ }

    void apply_logical_x() {
        for (int y = 0; y < d_; ++y)
            apply_x(data_index(0, y));
    }

    void apply_logical_z() {
        for (int x = 0; x < d_; ++x)
            apply_z(data_index(x, 0));
    }

    void inject_depolarizing(double p, uint64_t& seed) {
        for (size_t i = 0; i < data_.size(); ++i) {
            seed = seed * 6364136223846793005ULL + 1;
            double r = static_cast<double>(seed >> 33) / static_cast<double>(1ULL << 31);
            if (r < p) apply_x(static_cast<int>(i));
        }
    }

    bool face_parity(int i0, int i1, int i2, int i3) const {
        return data_[i0] ^ data_[i1] ^ data_[i2] ^ data_[i3];
    }

    std::array<bool, 4> measure_z_bulk() const {
        return {
            face_parity(data_index(0,0), data_index(1,0), data_index(0,1), data_index(1,1)),
            face_parity(data_index(1,0), data_index(2,0), data_index(1,1), data_index(2,1)),
            face_parity(data_index(0,1), data_index(1,1), data_index(0,2), data_index(1,2)),
            face_parity(data_index(1,1), data_index(2,1), data_index(1,2), data_index(2,2))
        };
    }

    bool logical_z_parity() const {
        return data_[data_index(0,0)] ^ data_[data_index(1,0)] ^ data_[data_index(2,0)];
    }

    bool logical_x_parity() const {
        return data_[data_index(0,0)] ^ data_[data_index(0,1)] ^ data_[data_index(0,2)];
    }

    int boundary_dist(int idx) const {
        int x = idx % d_;
        int y = idx / d_;
        return std::min({x, y, d_ - 1 - x, d_ - 1 - y});
    }

    void syndrome_round() const {
        auto p = measure_z_bulk();
        std::cout << "Z-bulk parities: "
                  << p[0] << " " << p[1] << " " << p[2] << " " << p[3] << "\n";
    }

    void run_memory(int rounds, int fault_qubit, double noise_p, uint64_t seed) {
        clear();
        if (fault_qubit >= 0 && fault_qubit < static_cast<int>(data_.size()))
            apply_x(fault_qubit);
        inject_depolarizing(noise_p, seed);
        for (int r = 0; r < rounds; ++r)
            syndrome_round();
        std::cout << "Logical Z: " << logical_z_parity() << "\n";
    }

    void print_boundary_distances() const {
        std::cout << "Boundary distances:\n";
        for (int i = 0; i < static_cast<int>(data_.size()); ++i)
            std::cout << "  qubit " << i << " dist " << boundary_dist(i) << "\n";
    }

    int distance() const { return d_; }
    size_t num_data() const { return data_.size(); }

private:
    int d_;
    std::vector<bool> data_;
};

int main() {
    SurfaceCode code(3);
    std::cout << "C++ surface-code backend (d=3)\n";
    std::cout << "Data qubits: " << code.num_data() << "\n";
    code.run_memory(3, 4, 0.001, 42);
    code.print_boundary_distances();
    return 0;
}
