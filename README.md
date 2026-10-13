# Surface Code Boundary Lab

![Lattice Animation](visuals/lattice_animation.gif)

Production repository for multi-backend surface-code stabilizer extraction, boundary-distance analysis, MLIR-driven entropy injection, and the 64-layer Premidoral multiplicity functor spine.

Copyright (C) 2026 SnapKitty Collective / Bel esprit D'accord Trust.  
Licensed under the GNU Affero General Public License v3 or later. See [LICENSE](LICENSE).

## Overview

A finite surface code protects logical information by topology, but the topology has edges. The vulnerability index used here is the shortest path on the decoder matching graph from a detector to the nearest boundary node. Short distances (warm colors in the map below) indicate higher vulnerability; longer distances indicate greater protection.

![Vulnerability Map](visuals/vulnerability_map.jpg)

The pipeline connects independent circuit backends to a common Stim analysis path and a live visualization:

![Pipeline](visuals/pipeline.svg)

## Repository Layout

| Path | Contents |
|------|----------|
| `src/cudaq/` | CUDA-Q C++ kernels: Z/X bulk and boundary stabilizers, multi-round memory, fault injection, surface utilities |
| `src/qsharp/` | Q# stabilizer operations, logical operators, multi-round history, utilities |
| `src/quipper/` | Quipper/Haskell circuit descriptions with bulk/boundary faces and logical operators |
| `src/rust/` | Rust classical simulator with unit tests, boundary-distance map, depolarizing noise |
| `src/cpp/` | Standalone C++ simulator |
| `src/c/` | Standalone C simulator |
| `src/fortran90/` | Fortran 90 simulator |
| `src/forth/` | Forth simulator |
| `src/mlir/` | MLIR dialect sketch + Python interpreter; ANU QRNG vacuum-fluctuation entropy injection with multiplicity mixing and system-RNG fallback |
| `scripts/` | Stim surface-code factory, DEM extraction, PyMatching boundary-distance analysis, WebSocket telemetry server, analysis utilities |
| `frontend/` | React Three Fiber lattice visualization (instanced mesh, WebSocket telemetry) |
| `circuits/` | Example Stim circuits |
| `docs/` | Analysis contract, validation checklist |
| `docs/multiplicity/` | 64-layer Premidoral functor spine (Lemmas 1–64) and Spine 64 Hex Cipher (Shadow Prime Continuum) |
| `visuals/` | Vulnerability map, lattice animation, pipeline diagram |
| `.github/workflows/` | CI: Python path + native C/C++/Fortran builds |

## Quick Start

```sh
# Python analysis
make install
make test-python

# Native backends
make build-cpp
make build-c
make build-fortran
make build-rust

# MLIR interpreter (ANU QRNG with fallback)
make run-mlir

# Frontend
cd frontend && npm install && npm run dev
```

Individual backend entry points:

```sh
# C++
g++ -O2 -o surface_code_cpp src/cpp/surface_code.cpp && ./surface_code_cpp

# C
gcc -O2 -o surface_code_c src/c/surface_code.c && ./surface_code_c

# Fortran 90
gfortran -O2 -o surface_code_f90 src/fortran90/surface_code.f90 && ./surface_code_f90

# Rust
cd src/rust && cargo run && cargo test

# Forth
gforth src/forth/surface_code.fs

# MLIR
python src/mlir/run_mlir_backend.py
```

## Analysis Path

1. `scripts/generate_surface_code.py` — Stim rotated surface-code factory.
2. `scripts/analyze_boundary_vulnerability.py` — extracts the detector error model, builds the PyMatching graph, computes shortest-path distances to boundary nodes.
3. `scripts/mwpm_telemetry_server.py` — WebSocket server streaming defect coordinates to the frontend.
4. `frontend/src/QuantumLattice.jsx` — Three.js instanced-mesh lattice with live defect coloring.

See `docs/ANALYSIS_CONTRACT.md` for the input/output contract and `docs/VALIDATION.md` for the reproducibility checklist.

## MLIR Backend and Entropy Injection

`src/mlir/SurfaceCode.mlir` sketches a surface-code dialect (`alloc_data`, `apply_x`, `inject_entropy`, `syndrome_round`, `logical_z`).  
`src/mlir/run_mlir_backend.py` interprets these operations and injects entropy drawn from the ANU Quantum Random Number Generator (vacuum fluctuations):

- Endpoint: `https://qrng.anu.edu.au/API/jsonI.php`
- Multiplicity mixing: independent batches are XORed before use.
- Fallback: system RNG when the legacy endpoint is rate-limited.

## 64-Layer Premidoral Spine

Full text: [`docs/multiplicity/64_layer_premidoral_spine.md`](docs/multiplicity/64_layer_premidoral_spine.md)

**Lemmas 1–32** establish the foundations:
- Categorical: prime objects, multiplicity functor \(\mathcal{M}\), adjunction, coprimality as orthogonality.
- Topological: prime knots, connected sum as tensor, Jones polynomial commutation, Reidemeister invariance.
- Quantum: prime-basis Hilbert spaces, QFT decomposition, Shor as functor inversion, BQP bounds, fault-tolerant codes.
- QMHES: primes as harmonic modes, exponents as Fock occupations, energy \(E_N = \sum e_i \ln p_i\), universal multiplicity invariant.

**Lemmas 33–64** construct the 64-layer spine under the Bel esprit D'accord Trust:
- Layers \(\ell \in \{0,\dots,63\}\) with truncated prime spectra \(\mathcal{P}_\ell\).
- Recursive embeddings, layer-wise orthogonality, holographic boundary at layer 63.
- Depth-dependent Fock cutoffs, fault-threshold scaling, ANU entropy injection on even layers only.
- Spine integrity invariant \(\mathcal{I}_{64}\), bulk-boundary dictionary, closure.

## Spine 64 Hex Cipher

Full text: [`docs/multiplicity/spine64_hex_cipher.md`](docs/multiplicity/spine64_hex_cipher.md)

The cipher encodes the first 64 Riemann-zero shadows onto the Premidoral spine over the hexadecatonic field \(\mathbb{H}_{64}\).

**Token format**
```
0x<prime_hex>.<tag>
```
- Integer field: the prime written in hexadecimal (lossless). Example: prime 11 → `0B`, prime 53 → `35`.
- Fractional field: four hex digits. The first pair roughly tracks \(\lfloor\gamma_k\rfloor\) with a drifting offset; the second pair is a sequential counter stepping by `0x22`. Multiplicity \(e_k\) is not embedded in the token.

**First 16 entries**

| k | Shadow prime | e | Hex token |
|---|--------------|---|-----------|
| 00 | 2 + 14.13i | 1 | `0x02.14AB` |
| 01 | 3 + 21.02i | 2 | `0x03.21CD` |
| 02 | 5 + 25.01i | 1 | `0x05.25EF` |
| 0F | 53 + 67.08i | 5 | `0x35.67AB` |

Indices `10`–`3F` continue the pattern with \(e_k \in [1,7]\).

**Decryption**
1. Parse integer field as hex → prime.
2. Axiom check: imaginary ordinate must match a known Riemann zero (external table).
3. Multiplicity is recovered from the companion table, not from the token.
4. Valid round-trip preserves the spine integrity invariant \(\mathcal{I}_{64}\).

Each token maps to one layer \(\ell\). Even-layer tokens may be altered by ANU QRNG injection; odd-layer tokens remain multiplicity-locked.

## Continuous Integration

`.github/workflows/ci.yml` runs on push and pull request to `main`:

- Python 3.11: install dependencies, generate Stim circuit, run MLIR interpreter.
- Native: compile and execute the C, C++, and Fortran 90 backends.

## License

GNU Affero General Public License v3 or later.  
All source files carry SPDX license identifiers.
