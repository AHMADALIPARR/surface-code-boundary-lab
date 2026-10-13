# Surface Code Boundary Lab

[![Pages](https://img.shields.io/badge/demo-live-00E5FF?style=flat-square)](https://ahmadaliparr.github.io/surface-code-boundary-lab/docs/)
[![License](https://img.shields.io/badge/license-AGPL--3.0-blue?style=flat-square)](LICENSE)

**Live demo:** [ahmadaliparr.github.io/surface-code-boundary-lab/docs](https://ahmadaliparr.github.io/surface-code-boundary-lab/docs/)

Multi-backend surface-code laboratory: stabilizer extraction, boundary-distance analysis, MLIR entropy injection, and the 64-layer Premidoral spine.

![Lattice](visuals/lattice_animation.gif)

## Preview

| Quantum Lens | Maze | Z408 Cipher |
|---|---|---|
| [Open](https://ahmadaliparr.github.io/surface-code-boundary-lab/docs/quantum_lens.html) | [Open](https://ahmadaliparr.github.io/surface-code-boundary-lab/docs/maze.html) | [Open](https://ahmadaliparr.github.io/surface-code-boundary-lab/docs/z408.html) |

![Vulnerability map](visuals/vulnerability_map.jpg)


## Visualizations

![Bloch sphere](visuals/quantum/bloch.png)

| Lattice | Circuit |
|---|---|
| ![lattice](visuals/quantum/lattice.svg) | ![circuit](visuals/quantum/circuit.svg) |

## Layout

| Path | What |
|---|---|
| `src/cudaq` `src/qsharp` `src/quipper` | Circuit backends |
| `src/rust` `src/cpp` `src/c` `src/fortran90` `src/forth` | Classical simulators |
| `src/mlir` | MLIR sketch + ANU QRNG entropy |
| `src/cipher` | AES MixColumns, Z408, Z340, maze block cipher |
| `src/maze` | Voyager maze, Many-Worlds, QSL, bifurcation |
| `scripts` | Stim factory, boundary analysis, telemetry |
| `gui` / `docs` | Browser interfaces (Pages) |
| `docs/multiplicity` | 64-layer spine + hex cipher |

## Run

```sh
make install && make test-python
make build-cpp
PYTHONPATH=src/maze python3 src/maze/bifurcation.py
```

## Docs

- [64-layer spine](docs/multiplicity/64_layer_premidoral_spine.md)
- [Hex cipher](docs/multiplicity/spine64_hex_cipher.md)
- [Analysis contract](docs/ANALYSIS_CONTRACT.md)

## License

AGPL-3.0-or-later. Copyright (C) 2026 SnapKitty Collective / Bel esprit D'accord Trust.
