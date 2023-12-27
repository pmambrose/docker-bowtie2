#!/bin/bash

# Bind variable to detect machine architecture
arch=$(uname -m)

# Build AMD64 docker image if Intel/AMD x86 architecture is detected
if [ "$arch" = "x86_64" ]; then
  echo "The architecture is amd64"
  docker build -t bowtie2docker ./bowtie2-amd64

# Build ARM64 docker image if Apple Silicon or other ARM archtitecture is detected
elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
  echo "The architecture is arm64"
  docker build -t bowtie2docker ./bowtie2-arm64

# Do not build if neither architecture is detected
else
  echo "The architecture is not supported"
fi