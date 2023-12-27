# Bowtie2 v2.5.2 Dockerfile for Native Apple M1+ Silicon (ARM64) and Intel/AMD (x86_64) Containers

This repository contains a Dockerfile for [Bowtie2](https://bowtie-bio.sourceforge.io/bowtie2/index.shtml) version 2.5.2 (released on October 14, 2023) specifically designed to detect the computer architecture and create a native Docker container image for either Apple M1/2/3+ Silicon (ARM64) or Intel/AMD (x86_64) chips.

## Overview

Bowtie2 is a popular tool for aligning sequencing reads to long reference sequences. This Dockerfile automates the installation of Bowtie2 in a Docker container, ensuring a consistent and reproducible environment for genomic analysis.

## Features

-   **Architecture Detection**: Automatically detects the host's CPU architecture (ARM64 or x86_64) and builds a native compatible Docker image. For example, a docker image built on Apple M1/2/3+ Silicon computers will contain bowtie2 and all dependencies natively compiled for Apple's `arm64` architecture, which precludes the need for a `Rosetta2` emulation layer, boosting performance and also minimizing the risk of emulator compatibility errors and ensuring uninterrupted compatibility if Apple drops `Rosetta2` support in future OSX updates.
-   **Optimized for Bowtie2 v2.5.2, Released Oct 14, 2023**: Specifically tailored for version 2.5.2 of Bowtie2 and includes all version-specific dependencies (eg. `bowtie2 v2.5.2` requires `python3 version >=3.10 & <3.11.0a0`)
-   **Easy to Use**: Simplifies the process of setting up Bowtie2, especially on systems with compatibility issues.

## Prerequisites

-   Docker installed on your machine. Easiest way to do this is by installing [Docker Desktop](https://www.docker.com/products/docker-desktop/).
-   Basic knowledge of Docker commands. Examples are given below.

## Usage

1.  **Clone the Repository**:

    ``` bash
    git clone https://github.com/pmambrose/docker-bowtie2.git
    cd docker-bowtie2
    ```

-   Alternatively you can also download the repository as a zip file, unpack, and then enter the directory in terminal.

2.  **Build the Docker Image**:

-   The Dockerfile will automatically detect the CPU architecture and build the appropriate native container image.

    ``` bash
    bash ./build_docker_bowtie2.sh
    ```

3.  **Run Bowtie2 in the Container:**:

-   In the general case, you can run bowtie2 commands in your terminal using the following template. Replace `command` with your desired Bowtie2 command (as you would in a native terminal, starting with `bowtie2` for example) and `/your/data/path` with your data directory. Since the bowtie2 container will reference the internal directory (`/home` which points to `/your/data/path`), adjust commands to point to files relatve to the container's `/home` directory. See examples below for more details.

    ``` bash
    docker run -v /your/data/path:/home bowtie2-docker /bin/bash -c "command"
    ```

-   We can run a simple test in which we create and enter a docker container created from our `bowtie2-docker` image and then run `bowtie2-help` in terminal:

    ``` bash
    docker run -it --name my_bowtie2_container bowtie2-docker  
    bowtie2 --help
    ```

-   Which produces the following output in terminal:

    ``` bash
    pradeep@Pradeeps-MacBook-Pro ~ % docker run -it --name my_bowtie2_container bowtie2-docker  
    root@40458769aa0b:/# bowtie2 --help
    Bowtie 2 version 2.5.2 by Ben Langmead (langmea@cs.jhu.edu, www.cs.jhu.edu/~langmea)
    Usage: 
    bowtie2 [options]* -x <bt2-idx> {-1 <m1> -2 <m2> | -U <r> | --interleaved <i> | -b <bam>} [-S <sam>]
    ```

## Examples

Here are some real-world examples of how I use this docker container within my workflow. Here, my terminal working directory `./` is set to the container's `/home` directory and the commands are run from within a bash script.

1.  **Generate a Bowtie2 Index For Alignments**:

-   To generate a small index using a `poliovirus.fasta` file in the terminals working directory into a relative path directory `./alignments/index/poliovirus` directory, while piping bowtie2's terminal output during index building to `indexing_terminal.txt`:

    ``` bash
    docker run -v ./:/home bowtie2-docker /bin/bash -c "bowtie2-build /home/poliovirus.fasta /home/alignments/index/poliovirus > /home/alignments/index/indexing_terminal.txt"
    ```

2.  **Align using Bowtie2**:

-   To align a compressed fastq file (with local relative path `./data/1_consensus.fastq.gz`) using the above sequence index and output as a compressed sam file (with local relative path `./alignments/2_alignment.sam.gz`), running Bowtie2 multi-threaded using 4 CPU threads:

    ``` bash
     docker run -v ./:/home bowtie2-docker /bin/bash -c "bowtie2 -q --phred33 --threads 4 --no-hd --no-sq --local -x /home/alignments/index/poliovirus -U /home/data/1_consensus.fastq.gz | gzip -c > /home/alignments/2_alignment.sam.gz"
    ```

## **Customization**

-   **Environment Variables**: Modify any necessary environment variables in the Dockerfile.

-   **Additional Dependencies**: Add any additional dependencies required for your specific workflow.

## **Contributing**

Contributions to improve the Dockerfile or address issues are welcome. Please submit a pull request or open an issue to discuss potential changes.

## **License**

This Dockerfile is distributed under the MIT license.

## **Contact**

For help or feedback, please contact me at [154608358+pmambrose\@users.noreply.github.com](mailto:154608358+pmambrose@users.noreply.github.com).

## **Acknowledgements**

-   Thanks to [Benjamin Langmead](https://engineering.jhu.edu/faculty/benjamin-langmead/) and the Bowtie2 team for developing and maintaining the software.

-   This Dockerfile is inspired by community contributions and best practices.