# Use the official ubuntu 22.04 base image
FROM ubuntu:22.04

# Update the package lists and install necessary packages
RUN apt-get update && apt-get install -y \
    unzip \
    wget \
    gcc \
    g++ \
    libtbb-dev \
    perl

# Set the default command to be executed when the container is run
CMD ["/bin/bash"]