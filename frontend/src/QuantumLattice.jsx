# SPDX-License-Identifier: AGPL-3.0-or-later
#
# Copyright (C) 2026 SnapKitty Collective
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License
# as published by the Free Software Foundation, either version 3
# of the License, or (at your option) any later version.

import React, { useRef, useEffect, useState } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import { Line } from '@react-three/drei'
import * as THREE from 'three'

const LATTICE_SIZE = 1000; 
const tempObject = new THREE.Object3D();
const tempColor = new THREE.Color();

export function QuantumLattice({ coordinates }) {
  const meshRef = useRef();
  const [activeDefects, setActiveDefects] = useState(new Set());
  const [errorPaths, setErrorPaths] = useState([]);

  useEffect(() => {
    const ws = new WebSocket("ws://localhost:8765");
    ws.onmessage = (event) => {
      const data = JSON.parse(event.data);
      if (data.type === "MWPM_TELEMETRY") {
        setActiveDefects(new Set(data.metrics.active_defects));
        setErrorPaths(data.routing_paths);
      }
    };
    return () => ws.close();
  }, []);

  useFrame(() => {
    if (!meshRef.current) return;
    
    coordinates.forEach((coord, i) => {
      tempObject.position.set(coord.x, coord.y, 0);
      tempObject.updateMatrix();
      meshRef.current.setMatrixAt(i, tempObject.matrix);
      
      const isActive = activeDefects.has(i);
      tempColor.set(isActive ? '#ff0044' : '#0044ff');
      meshRef.current.setColorAt(i, tempColor);
    });
    
    meshRef.current.instanceMatrix.needsUpdate = true;
    if (meshRef.current.instanceColor) meshRef.current.instanceColor.needsUpdate = true;
  });

  return (
    <group>
      <instancedMesh ref={meshRef} args={[null, null, LATTICE_SIZE]}>
        <sphereGeometry args={[0.2, 16, 16]} />
        <meshBasicMaterial toneMapped={false} />
      </instancedMesh>

      {errorPaths.map((path, index) => (
        <Line 
          key={index}
          points={path.map(id => [coordinates[id].x, coordinates[id].y, 0])} 
          color="#ffcc00" 
          lineWidth={3} 
        />
      ))}
    </group>
  )
}

export default function App() {
  const coordinates = Array.from({ length: 49 }, (_, i) => ({
    x: (i % 7) * 1.5 - 4.5,
    y: Math.floor(i / 7) * 1.5 - 4.5,
  }));

  return (
    <Canvas camera={{ position: [0, 0, 15], fov: 50 }}>
      <ambientLight intensity={0.5} />
      <QuantumLattice coordinates={coordinates} />
    </Canvas>
  );
}
