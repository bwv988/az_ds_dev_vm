# az_ds_dev_vm

Terraform scripts to spool up a Data Science dev box in Azure.

## Prerequisites

Follow the TerraForm and AZ CLI setup instructions here: 

https://docs.microsoft.com/en-us/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure

https://www.terraform.io/downloads

## Additional installations

### VM
TODO: Add to provisioning script.

```bash
# Install Miniconda.

# Install JupyterLab.
conda install jupyterlab ipywidgets


# Install PyTorch.
conda install pytorch torchvision torchaudio cpuonly -c pytorch
```

### Client
On the client, open an SSH tunnel to connect to JupyterLab:

```
ssh -N -L 8888:localhost:8888 {user]@{host}
```

