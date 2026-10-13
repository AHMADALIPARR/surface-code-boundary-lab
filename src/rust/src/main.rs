// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later.

//! Rust backend for the Surface Code Boundary Lab.
//!
//! Classical simulation of a distance-3 rotated surface code:
//! bulk Z/X faces, boundary weight-2 checks, logical operators,
//! multi-round syndrome collection, and simple depolarizing noise.

use std::collections::HashMap;

/// Data-qubit coordinate on a distance-d lattice.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Coord {
    pub x: usize,
    pub y: usize,
}

impl Coord {
    pub fn index(self, d: usize) -> usize {
        self.y * d + self.x
    }

    pub fn from_index(d: usize, idx: usize) -> Self {
        Self {
            x: idx % d,
            y: idx / d,
        }
    }
}

/// A stabilizer face (list of data-qubit indices).
#[derive(Clone, Debug)]
pub struct Face {
    pub qubits: Vec<usize>,
    pub is_x: bool,
}

/// Distance-3 rotated surface code patch.
pub struct SurfaceCode {
    pub distance: usize,
    pub data: Vec<bool>, // true = |1>, false = |0> in computational basis
}

impl SurfaceCode {
    pub fn new(distance: usize) -> Self {
        Self {
            distance,
            data: vec![false; distance * distance],
        }
    }

    pub fn data_index(&self, x: usize, y: usize) -> usize {
        y * self.distance + x
    }

    /// Weight-4 Z-plaquettes.
    pub fn z_plaquettes(&self) -> Vec<Face> {
        let d = self.distance;
        let mut faces = Vec::new();
        for y in 0..d.saturating_sub(1) {
            for x in 0..d.saturating_sub(1) {
                faces.push(Face {
                    qubits: vec![
                        self.data_index(x, y),
                        self.data_index(x + 1, y),
                        self.data_index(x, y + 1),
                        self.data_index(x + 1, y + 1),
                    ],
                    is_x: false,
                });
            }
        }
        faces
    }

    /// Weight-4 X-plaquettes (same geometry; measured in X basis).
    pub fn x_plaquettes(&self) -> Vec<Face> {
        self.z_plaquettes()
            .into_iter()
            .map(|mut f| {
                f.is_x = true;
                f
            })
            .collect()
    }

    /// Weight-2 Z-boundary checks (top and bottom edges).
    pub fn z_boundary(&self) -> Vec<Face> {
        let d = self.distance;
        let mut checks = Vec::new();
        for x in 0..d.saturating_sub(1) {
            checks.push(Face {
                qubits: vec![self.data_index(x, 0), self.data_index(x + 1, 0)],
                is_x: false,
            });
            checks.push(Face {
                qubits: vec![self.data_index(x, d - 1), self.data_index(x + 1, d - 1)],
                is_x: false,
            });
        }
        checks
    }

    /// Weight-2 X-boundary checks (left and right edges).
    pub fn x_boundary(&self) -> Vec<Face> {
        let d = self.distance;
        let mut checks = Vec::new();
        for y in 0..d.saturating_sub(1) {
            checks.push(Face {
                qubits: vec![self.data_index(0, y), self.data_index(0, y + 1)],
                is_x: true,
            });
            checks.push(Face {
                qubits: vec![self.data_index(d - 1, y), self.data_index(d - 1, y + 1)],
                is_x: true,
            });
        }
        checks
    }

    /// Apply a Pauli X on a data qubit.
    pub fn apply_x(&mut self, idx: usize) {
        if idx < self.data.len() {
            self.data[idx] = !self.data[idx];
        }
    }

    /// Apply a Pauli Z (phase; tracked only for completeness).
    pub fn apply_z(&mut self, idx: usize) {
        // Computational-basis state is unchanged by Z; phase is omitted
        // in this classical bit model.
        let _ = idx;
    }

    /// Logical Z: product of Z on the first row.
    pub fn apply_logical_z(&mut self) {
        for x in 0..self.distance {
            self.apply_z(self.data_index(x, 0));
        }
    }

    /// Logical X: product of X on the first column.
    pub fn apply_logical_x(&mut self) {
        for y in 0..self.distance {
            self.apply_x(self.data_index(0, y));
        }
    }

    /// Simple depolarizing noise: flip each data qubit with probability p.
    pub fn inject_depolarizing(&mut self, p: f64, rng: &mut impl FnMut() -> f64) {
        for i in 0..self.data.len() {
            if rng() < p {
                self.apply_x(i);
            }
        }
    }

    /// Measure a face in the computational basis (parity of the bits).
    /// For X-faces this is a placeholder that still returns Z-parity;
    /// a full X-basis measurement would require a basis change.
    pub fn measure_face(&self, face: &Face) -> bool {
        face.qubits.iter().fold(false, |acc, &q| acc ^ self.data[q])
    }

    /// One full syndrome round: Z-bulk, X-bulk, Z-boundary, X-boundary.
    pub fn syndrome_round(&self) -> Syndrome {
        Syndrome {
            z_bulk: self.z_plaquettes().iter().map(|f| self.measure_face(f)).collect(),
            x_bulk: self.x_plaquettes().iter().map(|f| self.measure_face(f)).collect(),
            z_boundary: self.z_boundary().iter().map(|f| self.measure_face(f)).collect(),
            x_boundary: self.x_boundary().iter().map(|f| self.measure_face(f)).collect(),
        }
    }

    /// Multi-round memory experiment.
    pub fn run_memory(
        &mut self,
        rounds: usize,
        fault_qubit: Option<usize>,
        noise_p: f64,
        mut rng: impl FnMut() -> f64,
    ) -> MemoryResult {
        if let Some(q) = fault_qubit {
            self.apply_x(q);
        }
        self.inject_depolarizing(noise_p, &mut rng);

        let mut history = Vec::with_capacity(rounds);
        for _ in 0..rounds {
            history.push(self.syndrome_round());
        }

        let final_data = self.data.clone();
        MemoryResult {
            history,
            final_data,
            logical_z: self.logical_z_parity(),
        }
    }

    /// Logical Z parity: parity of the first row.
    pub fn logical_z_parity(&self) -> bool {
        (0..self.distance)
            .map(|x| self.data[self.data_index(x, 0)])
            .fold(false, |acc, b| acc ^ b)
    }

    /// Logical X parity: parity of the first column.
    pub fn logical_x_parity(&self) -> bool {
        (0..self.distance)
            .map(|y| self.data[self.data_index(0, y)])
            .fold(false, |acc, b| acc ^ b)
    }

    /// Geometric distance from each data qubit to the nearest boundary.
    pub fn boundary_distance_map(&self) -> HashMap<usize, usize> {
        let d = self.distance;
        let mut map = HashMap::new();
        for idx in 0..self.data.len() {
            let c = Coord::from_index(d, idx);
            let dist = c.x.min(c.y).min(d - 1 - c.x).min(d - 1 - c.y);
            map.insert(idx, dist);
        }
        map
    }
}

/// One round of syndrome bits.
#[derive(Clone, Debug)]
pub struct Syndrome {
    pub z_bulk: Vec<bool>,
    pub x_bulk: Vec<bool>,
    pub z_boundary: Vec<bool>,
    pub x_boundary: Vec<bool>,
}

/// Result of a multi-round memory experiment.
#[derive(Clone, Debug)]
pub struct MemoryResult {
    pub history: Vec<Syndrome>,
    pub final_data: Vec<bool>,
    pub logical_z: bool,
}

fn main() {
    let mut code = SurfaceCode::new(3);
    let mut seed = 0u64;
    let mut rng = || {
        // Tiny LCG for reproducibility.
        seed = seed.wrapping_mul(6364136223846793005).wrapping_add(1);
        (seed >> 33) as f64 / (1u64 << 31) as f64
    };

    println!("Rust surface-code backend (d=3)");
    println!("Data qubits: {}", code.data.len());
    println!("Z-plaquettes: {}", code.z_plaquettes().len());
    println!("Z-boundary checks: {}", code.z_boundary().len());
    println!("X-boundary checks: {}", code.x_boundary().len());

    let result = code.run_memory(3, Some(4), 0.001, &mut rng);
    println!("Rounds collected: {}", result.history.len());
    println!("Logical Z parity: {}", result.logical_z);

    let dist_map = code.boundary_distance_map();
    println!("Boundary distance map (first 9):");
    for i in 0..9 {
        println!("  qubit {}: dist {}", i, dist_map.get(&i).unwrap_or(&0));
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn logical_x_flips_first_column() {
        let mut code = SurfaceCode::new(3);
        assert!(!code.logical_x_parity());
        code.apply_logical_x();
        assert!(code.logical_x_parity());
    }

    #[test]
    fn boundary_distance_center_is_largest() {
        let code = SurfaceCode::new(3);
        let map = code.boundary_distance_map();
        assert_eq!(*map.get(&4).unwrap(), 1); // center of 3x3
        assert_eq!(*map.get(&0).unwrap(), 0); // corner
    }

    #[test]
    fn z_plaquettes_count() {
        let code = SurfaceCode::new(3);
        assert_eq!(code.z_plaquettes().len(), 4);
    }
}
