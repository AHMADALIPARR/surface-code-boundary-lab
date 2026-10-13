# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 SnapKitty Collective

MLIR Surface-Code Backend
=========================

This directory contains a textual MLIR dialect sketch (`SurfaceCode.mlir`)
and a Python interpreter (`run_mlir_backend.py`) that executes the operations.

Entropy injection
-----------------
The runner fetches true quantum random numbers from the ANU QRNG
(vacuum-fluctuation measurements) at:

  https://qrng.anu.edu.au/API/jsonI.php?length=N&type=uint8

Multiplicity mixing XORs `multiplicity` independent batches before use,
increasing the entropy per injected bit. The legacy endpoint is rate-limited
(~1 request/minute); the runner caches a batch and falls back to the system
RNG if the service is unavailable.

Run
---
```sh
python src/mlir/run_mlir_backend.py
```

The dialect operations currently interpreted:
- alloc_data / apply_x
- inject_entropy (ANU QRNG + multiplicity)
- syndrome_round (Z-bulk faces)
- logical_z
