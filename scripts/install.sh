#!/bin/bash
# This is custom data script is executed via cloud-init.
# Logs are here: /var/log/cloud-init-output.log

echo -e "\nVM setup script STARTED"

# Update and install packages.
apt-get update && \
apt-get upgrade -y && \
apt install -y build-essential  && \
apt install -y mc  && \
apt-get clean

# Install miniconda.
export CONDA_DIR="/opt/conda"
wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
/bin/bash ~/miniconda.sh -b -p ~/opt/conda

export PATH="~/opt/conda/bin:$PATH"

# Install conda packages.
conda install jupyterlab ipywidgets

conda install pytorch torchvision torchaudio cpuonly -c pytorch

pip install transformers==4.20.1

cat <<'EOF' >>~/.bashrc
# Adding CONDA to execution path.

export PATH="~/opt/conda/bin:$PATH"
EOF

# Run this code to kick off downloading the BLOOM model.
python - <<'EOF'
# We run this to download / cache the BLOOM model so it's available for later use.
from transformers import pipeline

classifier = pipeline("sentiment-analysis", 
                      model = "bigscience/bloom-1b3")
EOF

echo -e "\nVM setup script COMPLETED."