# docker_R_python

- Ubuntu 22.04

- Perl 5.36.0 (with plenv)
- Python 3.9 (with Miniconda)
    - MACS2-2.2.9.1

- R 4.x
    - BiocManager
    - Rstudio Desktop
    - Rstudio Server

- SAMtools 1.17
- SRAtoolkit 3.0.2
- BEDtools 2.31.0
- OpenBLAS 0.3.24

- user:password
    - ubuntu:ubuntu
    - rstudio:rstudio

## ChangeLog

- 2023.10
    -
    - Add OpenBLAS-0.3.24
    - Update bedtools from v2.30.0 to v2.31.0
    - Add LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/compat/:/usr/local/cuda/lib64

- 2023.06
  - Add fish
