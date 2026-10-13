#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# Copyright (C) 2026 SnapKitty Collective
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License
# as published by the Free Software Foundation, either version 3
# of the License, or (at your option) any later version.

from pathlib import Path
import stim

DISTANCE = 5
ROUNDS = 5
NOISE = 0.001

ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "circuits" / "noisy_surface_code.stim"
OUTPUT.parent.mkdir(parents=True, exist_ok=True)

circuit = stim.Circuit.generated(
    "surface_code:rotated_memory_z",
    distance=DISTANCE,
    rounds=ROUNDS,
    after_clifford_depolarization=NOISE,
    after_reset_flip_probability=NOISE,
    before_measure_flip_probability=NOISE,
    before_round_data_depolarization=NOISE,
)

circuit.to_file(str(OUTPUT))

print(f"Circuit: {OUTPUT}")
print(f"Distance: {DISTANCE}")
print(f"Rounds: {ROUNDS}")
print(f"Physical noise parameters: {NOISE:.4%}")
print(f"Qubits: {circuit.num_qubits}")
print(f"Detectors: {circuit.num_detectors}")
print(f"Observables: {circuit.num_observables}")
