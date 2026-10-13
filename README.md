# Surface Code Boundary Lab

![Lattice Animation](visuals/lattice_animation.gif)

**This README is an atlas.** It is not a conventional project summary. It is a self-contained map of the laboratory: the physical idea (detector-to-boundary distance as a vulnerability index), the independent circuit backends, the Stim generation and analysis path, the matching-graph geometry, and the interactive visualization that makes those distances visible. Read it once to understand what the repository measures; keep it open while you change noise models or decoder parameters so the spatial meaning of the numbers stays clear.

Copyright (C) 2026 SnapKitty Collective. Licensed under the GNU Affero General Public License, version 3 or later. See [LICENSE](LICENSE).

## What This Atlas Records

In a finite surface code the logical information is protected by topology, but the topology has edges. A detector that can reach a physical boundary with a short chain of errors is more vulnerable than a detector deep in the bulk, because the minimum-weight perfect matching algorithm can terminate the chain at the boundary at lower cost. The vulnerability index used throughout this laboratory is exactly that quantity: the shortest path, on the decoder’s matching graph, from a given detector to the nearest boundary node.

The static map that accompanies the repository (`visuals/vulnerability_map.jpg`) shows this index for a small rotated lattice. Warm colors mark short distances (high vulnerability); cool colors mark longer distances (greater protection). Corner and edge detectors consistently receive the lowest indices; the central detector receives the highest. That spatial pattern is the expected signature of a finite code. Because the distances are computed on the actual matching graph rather than from a geometric heuristic, the same procedure remains valid for biased noise or irregular lattices.

The animated lattice (`visuals/lattice_animation.gif`) is a lightweight preview of the same visual language used by the live frontend: blue spheres for bulk nodes, red spheres for active defects. The pipeline diagram (`visuals/pipeline.svg`) shows how the independent backends, the Stim circuit, the DEM extraction, and the visualization fit together.

## Architecture

Three independent circuit descriptions feed a common analysis path:

1. **Circuit description** — Quipper/Haskell, Q#, or CUDA-Q/C++ each implement a small surface-code Z-stabilizer fragment (4 data qubits, 2 ancillas). They are not claimed to be automatically equivalent; they exist so the same abstract parity-check idea can be expressed in the languages used by different groups.
2. **Noise model and sampling** — Stim loads either the hand-written repetition fixture or the generated distance-5, five-round rotated surface code and produces detector-error samples.
3. **DEM extraction and matching** — The detector error model is built; PyMatching constructs the matching graph. Boundary nodes are identified explicitly (never inferred from missing edges).
4. **Distance calculation** — For every detector the shortest path to a boundary is recorded. These distances become the vulnerability index.
5. **Visualization** — A React Three Fiber frontend receives live telemetry over WebSocket and renders the lattice with active defects in red and MWPM routing paths in gold.

![Pipeline](visuals/pipeline.svg)

The analysis stage is specified by a contract (`docs/ANALYSIS_CONTRACT.md`) rather than by a single monolithic script, so alternative decoders or coordinate extractors can be substituted without rewriting the rest of the pipeline.

## Directory Layout

```text
.
├── LICENSE
├── README.md                          # this atlas
├── requirements.txt
├── circuits/
│   ├── repetition_code_noisy.stim
│   └── noisy_surface_code.stim        # generated
├── docs/
│   ├── ANALYSIS_CONTRACT.md
│   └── VALIDATION.md
├── frontend/
│   ├── index.html
│   ├── package.json
│   ├── vite.config.js
│   └── src/
│       ├── main.jsx
│       └── QuantumLattice.jsx
├── scripts/
│   ├── generate_surface_code.py
│   ├── analyze_boundary_vulnerability.py
│   └── mwpm_telemetry_server.py
├── src/
│   ├── cudaq/repetition_syndrome.cpp
│   ├── qsharp/Main.qs
│   └── quipper/repetition_syndrome.hs
└── visuals/
    ├── lattice_animation.gif
    ├── pipeline.svg
    └── vulnerability_map.jpg
```

## Circuit Generation

The surface-code generator uses Stim’s built-in factory:

```python
circuit = stim.Circuit.generated(
    "surface_code:rotated_memory_z",
    distance=5,
    rounds=5,
    after_clifford_depolarization=0.001,
    after_reset_flip_probability=0.001,
    before_measure_flip_probability=0.001,
    before_round_data_depolarization=0.001,
)
```

Running `python scripts/generate_surface_code.py` (after `pip install stim`) writes `circuits/noisy_surface_code.stim` and reports qubit, detector, and observable counts. The same noise parameter is applied to every listed channel so the physical error rate is uniform and easy to reason about. For production studies the individual channels can be set independently.

The repetition-code fixture in `circuits/repetition_code_noisy.stim` is a hand-authored five-qubit circuit (three data, two ancilla) that injects a deterministic X on the middle data qubit and then performs noisy parity extraction. It is intentionally small so detector coordinates and boundary semantics can be inspected by eye.

## Multi-Backend Circuit Descriptions

Each backend lives in its own directory and is intended to be built with the corresponding toolchain.

- **Quipper** (`src/quipper/repetition_syndrome.hs`): Pure Haskell description of the four-data, two-ancilla Z-stabilizer fragment. Rendering requires a Quipper-compatible GHC environment.
- **Q#** (`src/qsharp/Main.qs`): Entry-point operation that returns the two parity results. Open the folder in a Microsoft Quantum Development Kit project.
- **CUDA-Q** (`src/cudaq/repetition_syndrome.cpp`): C++ kernel that can be compiled with `nvq++`. The sample does not imply execution on a physical QPU; it uses whatever target the installed CUDA-Q selects.

None of these backends is claimed to emit a circuit that is automatically equivalent to the Stim surface-code factory. They exist so that the same abstract parity-check idea can be expressed in the languages used by different research groups, and so that future equivalence-checking work has concrete artifacts to compare.

## Analysis Contract and Vulnerability Computation

The contract in `docs/ANALYSIS_CONTRACT.md` specifies the expected inputs and outputs of the analysis stage: load a Stim circuit, extract a detector error model, build the matching graph, identify boundary nodes explicitly, compute shortest-path distances, and visualize actual detector coordinates rather than abstract indices.

The validation checklist in `docs/VALIDATION.md` enumerates the manual and automated checks that must pass before a result is considered reproducible.

The concrete implementation is `scripts/analyze_boundary_vulnerability.py`. It loads the generated Stim circuit, extracts the detector error model with error decomposition, builds a PyMatching graph, identifies boundary nodes (those with a virtual edge to the boundary), runs an unweighted BFS from every boundary node to obtain the hop distance for each detector, and writes `visuals/vulnerability_atlas.json` containing, for every detector, its identifier, coordinates, distance to boundary, and a boundary flag.

That JSON is the machine-readable form of the vulnerability map. Because the distance is currently unweighted, it counts edges rather than the sum of log-likelihood ratios. When the noise is uniform the two quantities are monotonic; when the noise is biased they diverge, and a weighted version is a natural extension.

## Vulnerability Map

![Vulnerability Map: Detector-to-Boundary MWPM Distance](visuals/vulnerability_map.jpg)

The image below shows a 7×7 detector lattice. Each node is annotated with a detector identifier and a numerical vulnerability index equal to the shortest MWPM distance to a physical boundary. Color encodes the index. A dashed rectangle marks the physical boundary interface. Corner and edge detectors receive the lowest indices; the central detector receives the highest. This is the spatial signature the laboratory is designed to make reproducible.

The image `visuals/vulnerability_map.jpg` shows a 7×7 detector lattice. Each node is annotated with a detector identifier and a numerical vulnerability index equal to the shortest MWPM distance to a physical boundary. Color encodes the index. A dashed rectangle marks the physical boundary interface. Corner and edge detectors receive the lowest indices; the central detector receives the highest. This is the spatial signature the laboratory is designed to make reproducible.

## Interactive Frontend

The directory `frontend/` contains a Vite + React Three Fiber application that renders an instanced-mesh lattice. Neutral nodes are blue; nodes that appear in the current set of active defects turn red. Gold polylines trace the MWPM routing paths received from the telemetry server.

To run the visualizer:

```sh
cd frontend
npm install
npm run dev
```

In a second terminal:

```sh
pip install websockets
python scripts/mwpm_telemetry_server.py
```

The browser opens on port 5173 and the WebSocket server listens on `ws://localhost:8765`. The telemetry server currently emits synthetic defects and paths; replacing its body with a live PyMatching result is a one-function change. The lattice component expects an array of `{x, y}` coordinates; in a full deployment those coordinates are injected from the analysis stage that also produces the vulnerability map.

## Design Principles

1. **Explicit boundaries** — Boundary semantics are never inferred from the absence of an edge. They are declared.
2. **Independent backends** — Circuit descriptions are not mixed into a single executable. Equivalence is a research question, not an assumption.
3. **Contract-first analysis** — The analysis stage is specified by inputs, outputs, and invariants rather than by a particular Python script.
4. **Visual first-class** — Vulnerability is a spatial quantity. The map and the live lattice are part of the scientific record, not decorative.
5. **Copyleft for network software** — Because the laboratory includes a WebSocket service and a browser frontend, the Affero GPL is the appropriate license. Anyone who runs a modified version as a network service must offer the corresponding source to users of that service.

## Limitations and Future Work

- The current backends implement only a small stabilizer fragment. Extending them to a full rotated surface code is straightforward but not yet done.
- The telemetry server emits synthetic data. Wiring it to a live PyMatching decoder is the next integration step.
- No formal proof of circuit equivalence across backends is provided.
- The vulnerability index is a graph distance; it does not yet incorporate the probability weights of the matching graph.
- Hardware execution is out of scope. All circuits are classical simulations or descriptions.

Possible extensions include a weighted MWPM vulnerability map, an automatic boundary extractor for Stim circuits that use the standard surface-code coordinate conventions, a small property-based test suite that checks the analysis contract, and a comparison of the three backends against the Stim factory under a common noise model.

## How to Use This Atlas

Treat the README as the primary scientific record of the laboratory. When you change the noise model, re-run the generator and the analysis script, then compare the new `vulnerability_atlas.json` against the published map. When you add a new backend, keep it independent and document the exact stabilizer pattern it implements. When you modify the frontend, keep the color convention (blue bulk, red defects, gold paths) so the visual language stays consistent with the static map and the GIF.

The atlas is interactive in the sense that the same coordinates and distances that appear in the JSON and the static image are the ones rendered by the live lattice. Opening the frontend while the telemetry server is running lets you watch the matching graph’s current defects and paths move across the same geometry that the vulnerability index describes.

## Extended Notes on Boundary Semantics

In the rotated surface code the detectors form a checkerboard of X- and Z-type stabilizers. The physical boundary is not a geometric line drawn after the fact; it is the set of nodes that the matching algorithm is allowed to pair with at zero additional cost when an error chain terminates. Declaring those nodes explicitly, as required by the analysis contract, prevents a common class of off-by-one errors in which an edge detector is treated as bulk simply because it has degree three rather than four. The vulnerability index is therefore a pure graph distance on the matching graph after the boundary nodes have been inserted.

The same lattice coordinates that appear in the vulnerability map are the coordinates expected by the frontend. In a production deployment the analysis stage writes a JSON file containing both the distance map and the `{id, x, y}` array; the telemetry server reads that file and the React component receives the array as a prop. The current synthetic server demonstrates the wire protocol without requiring a full decoder run, which is useful for frontend development and for continuous-integration smoke tests.

A result is considered reproducible when the Stim circuit is generated by the committed script with the stated parameters (or the committed fixture is used unchanged), the detector error model is extracted with a documented Stim version, boundary nodes are listed explicitly in the analysis output, and the shortest-path distances match the published vulnerability map for the distance-5, five-round instance (within the tolerance given in `docs/VALIDATION.md`). The frontend should render the same set of active defects that the decoder reported for a given sample. The checklist is intentionally short. Its purpose is to make independent re-implementation straightforward rather than to prescribe a particular software stack.

## Acknowledgments

Stim and the surface-code circuit factory are the work of the Google Quantum AI team. PyMatching is the work of Oscar Higgott. Quipper, Q#, and CUDA-Q are the respective projects of their maintainers. The SnapKitty Collective provided the laboratory structure, the vulnerability-map concept, and the interactive visualization.

## License

This project is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

---

*Surface Code Boundary Lab — an atlas of detectors, boundaries, and the distances between them.*
