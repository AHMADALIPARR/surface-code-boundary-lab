# Surface Code Boundary Lab

**AGPL-3.0-or-later multi-backend laboratory for surface-code syndrome experiments, DEM extraction, MWPM boundary vulnerability analysis, and interactive lattice visualization.**

Copyright (C) 2026 SnapKitty Collective. See [LICENSE](LICENSE).

## Quick Start

```sh
pip install -r requirements.txt
python scripts/generate_surface_code.py
python scripts/analyze_boundary_vulnerability.py
```

The analysis script writes `visuals/vulnerability_atlas.json` with per-detector coordinates and shortest-path distances to the nearest boundary.

## Layout

- `src/qsharp/Main.qs` — Q# surface-code stabilizer fragment
- `src/cudaq/repetition_syndrome.cpp` — CUDA-Q matching kernel
- `src/quipper/repetition_syndrome.hs` — Quipper matching circuit
- `scripts/generate_surface_code.py` — Stim `surface_code:rotated_memory_z` factory (d=5, 5 rounds)
- `scripts/analyze_boundary_vulnerability.py` — DEM → PyMatching → boundary distances
- `frontend/` — React Three Fiber lattice visualizer (WebSocket telemetry)
- `circuits/repetition_code_noisy.stim` — small fixture

## Frontend

```sh
cd frontend && npm install && npm run dev
# in another terminal
python scripts/mwpm_telemetry_server.py
```

Blue nodes = bulk, red = active defects, gold = MWPM paths.

## License

GNU Affero General Public License v3 or later. Full text: https://www.gnu.org/licenses/agpl-3.0.txt
