# Surface Code Boundary Lab — Production Makefile
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 SnapKitty Collective / Bel esprit D'accord Trust

.PHONY: help install test-python build-cpp build-c build-rust build-fortran run-mlir clean

help:
	@echo "Targets:"
	@echo "  install        Install Python dependencies"
	@echo "  test-python    Run Stim generation and boundary analysis"
	@echo "  build-cpp      Compile C++ backend"
	@echo "  build-c        Compile C backend"
	@echo "  build-rust     Build Rust backend"
	@echo "  build-fortran  Compile Fortran 90 backend"
	@echo "  run-mlir       Run MLIR interpreter (ANU QRNG with fallback)"
	@echo "  clean          Remove build artifacts"

install:
	pip install -r requirements.txt

test-python: install
	python scripts/generate_surface_code.py
	python scripts/analyze_boundary_vulnerability.py || true

build-cpp:
	g++ -O2 -o build/surface_code_cpp src/cpp/surface_code.cpp
	./build/surface_code_cpp

build-c:
	gcc -O2 -o build/surface_code_c src/c/surface_code.c
	./build/surface_code_c

build-rust:
	cd src/rust && cargo build --release

build-fortran:
	gfortran -O2 -o build/surface_code_f90 src/fortran90/surface_code.f90
	./build/surface_code_f90

run-mlir:
	python src/mlir/run_mlir_backend.py

clean:
	rm -rf build dist *.o *.exe
	cd src/rust && cargo clean || true
