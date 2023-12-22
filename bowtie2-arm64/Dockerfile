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

RUN wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.5.2/bowtie2-2.5.2-linux-aarch64.zip
RUN unzip bowtie2-2.5.2-linux-aarch64.zip
RUN rm -rf bowtie2-2.5.2-linux-aarch64.zip
ENV PATH="/bowtie2-2.5.2-linux-aarch64:$PATH"

RUN bowtie2 --help

# Set the default command to be executed when the container is run
CMD ["/bin/bash"]