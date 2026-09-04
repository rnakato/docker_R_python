# docker_R_python

- Ubuntu 24.04 / 22.04

- GPU mode
   - 24.04: cuda:12.9.2-cudnn-runtime (CUDA 12.9, cuDNN 9.10)
   - 22.04: cuda:11.8.0-cudnn8-runtime (CUDA 11.8, cuDNN 8)

- Perl 5.42.3 (with plenv)
- Python 3.10 (with micromamba)
    - See [env.yaml](https://github.com/rnakato/docker_R_python/blob/master/micromamba/env.yaml) for details

- R 4.6.1
    - BiocManager (Bioconductor 3.23)
    - Rstudio Desktop
    - Rstudio Server

- SAMtools 1.24
- SRAtoolkit 3.4.1
- [pfastq-dump](https://github.com/inutano/pfastq-dump)
- BEDtools 2.31.1
- OpenBLAS 0.3.24
- ChIPseqTools
- MACS2-2.2.9.1
- SSP

- user:password
    - ubuntu:ubuntu
    - rstudio:rstudio

## ChangeLog

- 2026.09
  - Added Ubuntu 24.04
  - Image names are now versioned by Ubuntu release: `r_python` and `r_python_gpu`
    are renamed to `r_python_22.04` and `r_python_gpu_22.04`, and `r_python_24.04`
    and `r_python_gpu_24.04` are added
    - The CRAN repository is `noble-cran40` for 24.04 and `jammy-cran40` for 22.04
    - The single `Dockerfile` is split into `Dockerfile.22.04` and `Dockerfile.24.04`
  - Updated rstudio and rstudio-server from 2025.05.1-513 to 2026.08.2-200
    (one build covers Ubuntu 22/24)
  - Updated Perl from 5.36.0 to 5.42.3 (base image)
  - Updated SAMtools from 1.22.1 to 1.24 (base image)
  - Updated BEDtools from 2.31.0 to 2.31.1 (2.31.0 fails to compile with GCC 13 on 24.04)
  - Fixed the R package `graph`, which had never been installed because it was
    listed in `install.packages()` although it is a Bioconductor package;
    it is now installed via `BiocManager::install()`
  - `nvidia-cuda-toolkit` is no longer installed in GPU mode (base image);
    `nvcc` is not included, so use a `-devel` CUDA base image if you need to
    compile CUDA code

- 2026.06
  - Added ``isnumber.sh``
  - Updated Bioconductor 3.21 to 3.23

- 2026.04
  - Updated SRA Toolkit from 3.2.1 to v3.4.1
  - Updated SAMtools from 1.22.1 to 1.22.2
  
- 2026.03.2
  - Updated Bioconductor 3.21 to 3.22

- 2026.03
  - Added [pfastq-dump](https://github.com/inutano/pfastq-dump) (a bash implementation of parallel-fastq-dump)  and removed parallel-fastq-dump
  - Bug fix: lost path to sratoolkit 3.2.1 in PATH

- 2025.08
  - Updated SAMtools from 1.21 to 1.22.1
  - Updated SRA Toolkit from 3.1.1 to 3.2.1
  - Updated rstudio and rstudio-server to 2025.05.1-513
  - Added the ``--server-daemonize=0`` option to ``rserver.sh``

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

Run normal image (Ubuntu 24.04):

    docker run -it --rm rnakato/r_python_24.04 /bin/bash

Run with GPU:

    docker run -it --rm --gpus all rnakato/r_python_gpu_24.04 /bin/bash

Ubuntu 22.04 images are also available:

    docker run -it --rm rnakato/r_python_22.04 /bin/bash
    docker run -it --rm --gpus all rnakato/r_python_gpu_22.04 /bin/bash

The default user is `ubuntu`. Add `-u root` if you want to login as root:

    docker run -it --rm --gpus all -u root rnakato/r_python_gpu_24.04 /bin/bash

## Build images from Dockerfile

    version=24.04 # or 22.04

    # First, add execute permissions to the micromamba binary file and the scripts.
    chmod +x micromamba/bin/micromamba scripts/*
    # Build the image without GPU support
    docker build -f Dockerfile.$version -t youracount/r_python_$version --target normal .
    # Build the image with GPU support (CUDA)
    docker build -f Dockerfile.$version -t youracount/r_python_gpu_$version --target gpu .
