#!/bin/bash
set -e

echo "Building LuaJIT function package using Docker..."

docker build -t luajit-function-builder .
CONTAINER_ID=$(docker create luajit-function-builder)
docker cp $CONTAINER_ID:/output/function.zip dist/
docker rm $CONTAINER_ID

echo "Build complete! Package created: dist/function.zip"
ls -la dist/function.zip
