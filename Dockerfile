FROM rnakato/ubuntu_22.04:2024.02 as common
LABEL maintainer "Ryuichiro Nakato <rnakato@iqb.u-tokyo.ac.jp>"

USER root
WORKDIR /opt

ENV PATH $PATH:/opt/conda/bin/:/opt/scripts

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apt-file \
    apt-utils \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    curl \
    default-jre \
    gawk \
    gdebi-core \
    gfortran \
    git \
    gnupg \
    htop \
    imagemagick \
    libarchive-dev \
    libatlas-base-dev \
    libblas-dev \
    libboost-all-dev \
    libbz2-dev \
    libcairo2-dev \
    libcurl4-gnutls-dev \
    libfreetype6-dev \
    libgdal-dev \
    libgit2-dev \
    libglpk-dev \
    libglu1-mesa-dev \
    libgmp-dev \
    libgsl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libhdf5-dev \
    libhdf5-serial-dev \
    liblapack3 \
    liblapack-dev \
    libmagick++-dev \
    libssl-dev \
    libtool \
    libudunits2-dev \
    libv8-dev \
    libx11-dev \
    make \
    pigz \
    psmisc \
    qtbase5-dev qt5-qmake qtbase5-dev-tools qtchooser \
    sudo \
    unzip \
    vim \
    xorg \
    zlib1g-dev \
    && echo "deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" | tee -a /etc/apt/sources.list \
    && curl -sL "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x51716619E084DAB9" | apt-key add \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    r-base r-base-core r-recommended r-base-dev libclang-dev libxkbcommon-x11-0 \
    && apt-get upgrade -y \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# OpenBLAS
COPY OpenBLAS-0.3.24.tar.gz OpenBLAS-0.3.24.tar.gz
RUN tar zxvf OpenBLAS-0.3.24.tar.gz \
    && cd OpenBLAS-0.3.24 \
    && make \
    && make install \
    && rm -rf /opt/OpenBLAS-0.3.24 /opt/OpenBLAS-0.3.24.tar.gz /opt/OpenBLAS

# R packages
COPY .Rprofile /root/
#ENV JAVA_HOME /usr/lib/jvm/java-19-openjdk-amd64/
RUN R -e "install.packages(c('BiocManager'))" \
    && R -e "BiocManager::install(ask = FALSE)" \
    && R CMD javareconf \
    && R -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest','Rcpp' ,'sf', 'tidyverse', 'xlsx', 'hdf5r', 'igraph', 'VennDiagram', 'usethis', 'graph', 'rJava'))" \
    && R -e "BiocManager::install(c('multtest','rhdf5'))" \
    && R -e "devtools::install_github('IRkernel/IRkernel')"

# Install Rstudio Desktop and Server, and create user
RUN curl -LO https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.03.0-386-amd64.deb \
    && gdebi -n rstudio-2023.03.0-386-amd64.deb \
    && rm rstudio-2023.03.0-386-amd64.deb \
    && wget --quiet https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.03.0-386-amd64.deb \
    && gdebi -n rstudio-server-2023.03.0-386-amd64.deb \
    && rm rstudio-server-2023.03.0-386-amd64.deb \
    && useradd -s /bin/bash -m rstudio \
    && echo "rstudio:rstudio" | chpasswd

# Python 3.10
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py310_23.11.0-2-Linux-x86_64.sh -O ~/miniconda.sh \
    && bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && ln -s -f /opt/conda/bin/python /usr/bin/python

RUN conda update conda \
    && conda install -y numpy scipy matplotlib pandas seaborn scikit-learn scikit-learn-intelex \
    dash plotly black bokeh h5py click jupyter jupyterlab pytables setuptools \
    sphinx sphinx_rtd_theme fastcluster numba \
    && conda install -y -c conda-forge sphinx-autobuild nbsphinx python-igraph jupyterthemes umap-learn ncurses \
    && pip install --upgrade tables \
    && pip install --no-cache-dir Cython MACS2 notebook==6.5.6 sphinxcontrib.exceltable jupyter_contrib_nbextensions session_info tqdm

# bedtools
ENV v 2.31.0
COPY bedtools-$v.tar.gz bedtools-$v.tar.gz
RUN tar zxvf bedtools-$v.tar.gz \
    && cd bedtools2 && make \
    && rm /opt/bedtools-$v.tar.gz

# Jupyter config
COPY conf conf
RUN jupyter notebook --generate-config \
    && cat ./conf >> ~/.jupyter/jupyter_notebook_config.py \
    && rm ./conf
RUN R -e "IRkernel::installspec(user = FALSE)"

COPY scripts scripts
RUN chmod +x /opt/scripts/*sh

FROM rnakato/ubuntu_22.04:2024.02 as normal
LABEL maintainer="Ryuichiro Nakato <rnakato@iqb.u-tokyo.ac.jp>"
ENV PATH $PATH:/opt/conda/bin/:/opt/scripts:/opt/bedtools2/bin

COPY --from=common / /
USER ubuntu
WORKDIR /home/ubuntu
CMD ["/bin/bash"]


FROM rnakato/ubuntu_gpu_22.04:2024.02 as gpu
LABEL maintainer="Ryuichiro Nakato <rnakato@iqb.u-tokyo.ac.jp>"
ENV PATH $PATH:/opt/conda/bin/:/opt/scripts:/opt/bedtools2/bin

COPY --from=common / /
USER ubuntu
WORKDIR /home/ubuntu
CMD ["/bin/bash"]
