# Surface Code Boundary Lab

Production repository for multi-backend surface-code stabilizer extraction, boundary-distance analysis, and multiplicity-functor documentation.

![Lattice Animation](visuals/lattice_animation.gif)

Copyright (C) 2026 SnapKitty Collective / Bel esprit D'accord Trust.  
Licensed under the GNU Affero General Public License v3 or later. See [LICENSE](LICENSE).

## Components

| Path | Description |
|------|-------------|
| `src/cudaq/` | CUDA-Q C++ kernels (Z/X stabilizers, multi-round) |
| `src/qsharp/` | Q# operations and utilities |
| `src/quipper/` | Quipper/Haskell circuit descriptions |
| `src/rust/` | Rust classical simulator with tests |
| `src/cpp/` | Standalone C++ simulator |
| `src/c/` | Standalone C simulator |
| `src/fortran90/` | Fortran 90 simulator |
| `src/forth/` | Forth simulator |
| `src/mlir/` | MLIR dialect sketch + Python interpreter with ANU QRNG entropy injection |
| `scripts/` | Stim circuit factory, boundary-vulnerability analysis, telemetry server |
| `frontend/` | React Three Fiber lattice visualization |
| `docs/multiplicity/` | 64-layer Premidoral spine and Spine 64 Hex Cipher |
| `circuits/` | Example Stim circuits |
| `visuals/` | Vulnerability map, animation, pipeline diagram |

## Quick Start

```sh
# Python analysis path
make install
make test-python

# Native backends
make build-cpp
make build-c
make build-fortran
make build-rust

# MLIR interpreter (ANU QRNG with system-RNG fallback)
make run-mlir

# Frontend
cd frontend && npm install && npm run dev
```

## Analysis

The vulnerability index is the shortest-path distance on the decoder matching graph from a detector to the nearest boundary. See `docs/ANALYSIS_CONTRACT.md` and `docs/VALIDATION.md`.

## Multiplicity Documentation

- `docs/multiplicity/64_layer_premidoral_spine.md` — Lemmas 1–64
- `docs/multiplicity/spine64_hex_cipher.md` — Shadow Prime Continuum and hex cipher

## License

AGPL-3.0-or-later. All source files carry SPDX headers.
