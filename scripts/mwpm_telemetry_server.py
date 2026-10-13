#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# Copyright (C) 2026 SnapKitty Collective
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License
# as published by the Free Software Foundation, either version 3
# of the License, or (at your option) any later version.

"""Minimal WebSocket emitter for MWPM telemetry to the frontend lattice visualizer."""

import asyncio
import json
import random
import websockets

HOST = "localhost"
PORT = 8765

async def handler(websocket):
    while True:
        active = random.sample(range(49), k=random.randint(2, 6))
        paths = [[random.randint(0, 48) for _ in range(random.randint(2, 5))] for _ in range(random.randint(1, 3))]
        msg = {
            "type": "MWPM_TELEMETRY",
            "metrics": {"active_defects": active},
            "routing_paths": paths,
        }
        await websocket.send(json.dumps(msg))
        await asyncio.sleep(0.5)

async def main():
    async with websockets.serve(handler, HOST, PORT):
        print(f"MWPM telemetry server listening on ws://{HOST}:{PORT}")
        await asyncio.Future()

if __name__ == "__main__":
    asyncio.run(main())
