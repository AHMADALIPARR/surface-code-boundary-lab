/* SPDX-License-Identifier: AGPL-3.0-or-later
 * Copyright (C) 2026 SnapKitty Collective
 * Licensed under GNU Affero General Public License v3 or later.
 *
 * C backend for the Surface Code Boundary Lab.
 * Classical simulation of a distance-3 rotated surface code:
 * bulk Z faces, logical operators, multi-round syndrome,
 * boundary distances.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

#define D 3
#define NDATA (D * D)

static bool data_bits[NDATA];

static int data_index(int x, int y) {
    return y * D + x;
}

static void clear_data(void) {
    for (int i = 0; i < NDATA; ++i)
        data_bits[i] = false;
}

static void apply_x(int idx) {
    if (idx >= 0 && idx < NDATA)
        data_bits[idx] = !data_bits[idx];
}

static void apply_logical_x(void) {
    for (int y = 0; y < D; ++y)
        apply_x(data_index(0, y));
}

static void apply_logical_z(void) {
    /* phase-only in this bit model */
}

static bool face_parity(int i0, int i1, int i2, int i3) {
    return data_bits[i0] ^ data_bits[i1] ^ data_bits[i2] ^ data_bits[i3];
}

static void measure_z_bulk(bool out[4]) {
    out[0] = face_parity(data_index(0,0), data_index(1,0), data_index(0,1), data_index(1,1));
    out[1] = face_parity(data_index(1,0), data_index(2,0), data_index(1,1), data_index(2,1));
    out[2] = face_parity(data_index(0,1), data_index(1,1), data_index(0,2), data_index(1,2));
    out[3] = face_parity(data_index(1,1), data_index(2,1), data_index(1,2), data_index(2,2));
}

static bool logical_z_parity(void) {
    return data_bits[data_index(0,0)] ^ data_bits[data_index(1,0)] ^ data_bits[data_index(2,0)];
}

static bool logical_x_parity(void) {
    return data_bits[data_index(0,0)] ^ data_bits[data_index(0,1)] ^ data_bits[data_index(0,2)];
}

static int boundary_dist(int idx) {
    int x = idx % D;
    int y = idx / D;
    int a = x < y ? x : y;
    int b = (D - 1 - x) < (D - 1 - y) ? (D - 1 - x) : (D - 1 - y);
    return a < b ? a : b;
}

static void inject_depolarizing(double p, uint64_t *seed) {
    for (int i = 0; i < NDATA; ++i) {
        *seed = *seed * 6364136223846793005ULL + 1;
        double r = (double)(*seed >> 33) / (double)(1ULL << 31);
        if (r < p)
            apply_x(i);
    }
}

static void syndrome_round(void) {
    bool p[4];
    measure_z_bulk(p);
    printf("Z-bulk parities: %d %d %d %d\n", p[0], p[1], p[2], p[3]);
}

static void run_memory(int rounds, int fault_qubit, double noise_p, uint64_t seed) {
    clear_data();
    if (fault_qubit >= 0 && fault_qubit < NDATA)
        apply_x(fault_qubit);
    inject_depolarizing(noise_p, &seed);
    for (int r = 0; r < rounds; ++r)
        syndrome_round();
    printf("Logical Z: %d\n", logical_z_parity());
}

static void print_boundary_distances(void) {
    printf("Boundary distances:\n");
    for (int i = 0; i < NDATA; ++i)
        printf("  qubit %d dist %d\n", i, boundary_dist(i));
}

int main(void) {
    printf("C surface-code backend (d=3)\n");
    printf("Data qubits: %d\n", NDATA);
    run_memory(3, 4, 0.001, 42);
    print_boundary_distances();
    return 0;
}
