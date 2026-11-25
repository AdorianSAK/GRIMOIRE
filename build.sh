#!/bin/bash

set -e

echo "=== GRIMOIDE BUILD ==="

cmake -S . -B build
cmake --build build

echo "=== BUILD COMPLETE ==="
