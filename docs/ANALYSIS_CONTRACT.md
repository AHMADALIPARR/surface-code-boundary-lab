# Detector analysis contract

## Inputs

- A Stim circuit with explicit `DETECTOR` annotations.
- Optional `OBSERVABLE_INCLUDE` annotations for logical-observable evaluation.
- A pinned Stim version and a recorded extraction option set.
- A PyMatching version compatible with the chosen DEM.

## Required stages

1. Load and validate the circuit.
2. Record qubit, detector, observable, and measurement counts.
3. Extract the detector error model and record whether decomposition was requested.
4. Construct the matching decoder and sample synthetic detection events from the same circuit.
5. Decode batches and compare predicted observable flips with sampled observable flips.
6. Export the graph and print actual node/edge attributes before relying on any schema.
7. Compute shortest paths only when the chosen boundary representation is identified and justified.
8. Parse detector coordinates from circuit annotations; do not synthesize physical coordinates from detector IDs.
9. Render graph distances with labels that state these are decoder-graph metrics, not physical error probabilities.
10. Record versions, input hashes, seed where applicable, shot count, failure count, and uncertainty.

## Semantic safeguards

- A DEM error probability is not inherently a measured hardware calibration probability.
- A DEM instruction is not necessarily a unique physical fault.
- `num_errors` counts DEM error instructions, not unique hardware mechanisms.
- Graph edges may combine or decompose mechanisms and are not guaranteed to map one-to-one to physical qubits.
- Do not assume a boundary node is `None`, has index `num_detectors`, or carries `is_boundary=True`. Inspect the actual PyMatching export and version.
- Dijkstra's weighted result is the sum of edge costs. It is not itself a physical error probability or code distance.
- Hop count is graph-edge count, not automatically physical-qubit distance.
- A visualization's bounding box is a coordinate extent unless a trusted device topology explicitly defines it as a physical boundary.
