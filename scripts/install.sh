#!/bin/bash
# This is custom data script is executed via cloud-init.
# View logs:
# tail -f /var/log/cloud-init-output.log

# Change the username as needed.
export THE_USER="sral"

echo -e "\nVM setup script STARTED.\nRunning for user ${THE_USER}."

# Update and install packages.
# FIXME: This should be moved into a proper cloud-init template.
apt-get update && \
apt-get upgrade -y && \
apt install -y build-essential  && \
apt install -y mc  && \
apt-get clean

# Install miniconda for the user.
su ${THE_USER} <<'EOF'

export CONDA_DIR="/home/${THE_USER}/opt/conda"

wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
/bin/bash ~/miniconda.sh -b -p ~/opt/conda

export PATH="~/opt/conda/bin:$PATH"

# Add to the user's runtime path.
echo -e "\n\nexport PATH='~/opt/conda/bin:$PATH'" >> ~/.bashrc

# Install required conda packages.

conda create -n textgen
conda activate textgen
conda install torchvision torchaudio pytorch-cuda=11.7 git -c pytorch -c nvidia jupyterlab ipywidgets
conda install -c huggingface transformers

git clone https://github.com/oobabooga/text-generation-webui
cd text-generation-webui
pip install -r requirements.txt

# Run this code to kick-off downloading the BLOOM model.
# FIXME: Doesn't seem to work?
#python - <<'NESTED'
# We run this to download / cache the BLOOM model so it's available for later use.
#from transformers import pipeline

#classifier = pipeline("sentiment-analysis", 
                    model = "bigscience/bloom-1b3")
#NESTED
EOF

echo -e "\nVM setup script COMPLETED."