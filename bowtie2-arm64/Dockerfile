# Use the official ubuntu 22.04 base image
# Should auto install the appropriate version: ARM64 or AMD64
FROM ubuntu:22.04

# Update the package lists and install necessary packages
# Includes packages to download, unzip, and compile bowtie2
RUN apt-get update && apt-get install -y \
    unzip \
    wget \
    gcc \
    g++ \
    libtbb-dev \
    perl

# Download bowtie2 and unzip and set PATH variable
# This code for Apple Silicon installs the ARM64 version of bowtie2
# Should match the version of ubuntu (ARM64 vs AMD64)
RUN wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.5.2/bowtie2-2.5.2-linux-aarch64.zip
RUN unzip bowtie2-2.5.2-linux-aarch64.zip
RUN rm -rf bowtie2-2.5.2-linux-aarch64.zip
ENV PATH="/bowtie2-2.5.2-linux-aarch64:$PATH"

# Instantiate bowtie2 to compile (using gcc and perl) on first run
RUN bowtie2 --help

# Set the default command to be executed when the container is run
CMD ["/bin/bash"]