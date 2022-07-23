#!/bin/sh
# This is custom data script is executed via cloud-init.
# Logs are here: /var/log/cloud-init.log

# Update packages.
apt-get update && \
apt-get upgrade -y && \
apt-get install -y build-essentials  && \
apt-get install -y wget &&
apt-get clean

# Install miniconda.
export CONDA_DIR="/opt/conda"
wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
/bin/bash ~/miniconda.sh -b -p /opt/conda

