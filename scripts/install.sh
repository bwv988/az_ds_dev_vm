#!/bin/bash
# This is custom data script is executed via cloud-init.
#
# View logs:
# tail -f /var/log/cloud-init-output.log
# less /var/log/cloud-init-output.log

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
# Using the temporary data disk.

sudo chmod a+rw /mnt

export CONDA_DIR="/mnt/opt/conda"

wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
/bin/bash ~/miniconda.sh -b -p ${CONDA_DIR}

export PATH="${CONDA_DIR}/bin:$PATH"

# Add to the user's runtime path.
echo -e "\n\nexport PATH='${CONDA_DIR}/bin:$PATH'" >> ~/.bashrc

# Install required conda packages.
conda init bash
conda create -n textgen -y
conda activate textgen

# ON GPU VMs:
# conda install torchvision transformers torchaudio pytorch-cuda=11.7 git jupyterlab ipywidgets -c pytorch -c nvidia -y

# ON CPU VMs:
conda install pytorch transformers torchvision git jupyterlab ipywidgets torchaudio cpuonly -c pytorch -y 

# For TMUX
cd $HOME
git clone https://github.com/gpakosz/.tmux
ln -s -f .tmux/.tmux.conf


# Prepare Git and some other settings
cd $HOME
mkdir git
cd git
git clone https://github.com/bwv988/dotfiles.git
cd dotfiles
cp .tmux.conf.local $HOME/

# Clone the web UI
cd $HOME/git
git clone https://github.com/oobabooga/text-generation-webui
cd text-generation-webui
pip install -r requirements.txt

# Run this code to kick-off downloading the BLOOM model.
# FIXME: Doesn't seem to work?
python - <<'NESTED'

print(2+2)

# We run this to download / cache the BLOOM model so it's available for later use.
#from transformers import pipeline

#classifier = pipeline("sentiment-analysis", 
                    model = "bigscience/bloom-1b3")
NESTED
EOF

echo -e "\nVM setup script COMPLETED."