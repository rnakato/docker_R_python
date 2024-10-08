# docker_R_python

- Ubuntu 22.04

- GPU mode (cuda:11.8.0-cudnn8-runtime)
   - CUDA 11.8
   - cudnn 8

- Perl 5.36.0 (with plenv)
- Python 3.10 (with micromamba)
    - See [env.yaml](https://github.com/rnakato/docker_R_python/blob/master/micromamba/env.yaml) for details

- R 4.x
    - BiocManager
    - Rstudio Desktop
    - Rstudio Server

- SAMtools 1.21
- SRAtoolkit 3.1.1
- parallel-fastq-dump 0.6.7
- BEDtools 2.31.0
- OpenBLAS 0.3.24
- ChIPseqTools
- MACS2-2.2.9.1
- SSP

- user:password
    - ubuntu:ubuntu
    - rstudio:rstudio

## ChangeLog

- 2024.10
  - Updated SAMtools from 1.19.2 to 1.21
  - Updated SRA Toolkit from 3.0.10 to v3.1.1
  - Added [parallel-fastq-dump](https://github.com/rvalieris/parallel-fastq-dump)

- 2024.04
  - Changed Python environment from conda to micromamba (`/opt/micromamba`)

- 2024.02.2
  - Install MS core fonts (ttf-mscorefonts-installer)

- 2024.02
  - Installed `sudo`
  - Updated Miniconda from Python 3.9 to Python 3.10

- 2024.01
  - Updated SAMtools from 1.17 to 1.19.2
  - Updated SRAtoolkit from 3.0.2 to 3.0.10
  - Change WORKDIR from /opt to /home/ubuntu

- 2023.11
    - Removed LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/compat/:/usr/local/cuda/lib64

- 2023.10
    - Add OpenBLAS-0.3.24
    - Update bedtools from v2.30.0 to v2.31.0
    - Add LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/compat/:/usr/local/cuda/lib64

- 2023.06
  - Add fish


## Usage

Run normal image:

    docker run -it --rm rnakato/r_python /bin/bash

Run with GPU:

    docker run -it --rm --gpus all rnakato/r_python_gpu /bin/bash

The default user is `ubuntu`. Add `-u root` if you want to login as root:

    docker run -it --rm --gpus all -u root rnakato/r_python_gpu /bin/bash

## Build images from Dockerfile

    # normal
    docker build -t youracount/r_python --target normal .
    # with GPU
    docker build -t youracount/r_python_gpu --target gpu .
 