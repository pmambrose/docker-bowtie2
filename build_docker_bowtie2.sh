#!/bin/bash

arch=$(uname -m)

if [ "$arch" = "x86_64" ]; then
  echo "The architecture is amd64"
  # Add intel docker build command here
elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
  echo "The architecture is arm64"
  # Add apple silicon docker build command here
else
  echo "The architecture is not supported"
fi