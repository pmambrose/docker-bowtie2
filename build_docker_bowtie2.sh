#!/bin/bash

arch=$(uname -m)

if [ "$arch" = "x86_64" ]; then
  echo "The architecture is amd64"
elif [ "$arch" = "aarch64" ]; then
  echo "The architecture is arm64"
else
  echo "The architecture is not supported"
fi