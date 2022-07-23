# az_ds_dev_vm

Terraform scripts to spool up a Data Science dev box in Azure.

## Prerequisites

Terraform and AZ CLI installed.

If this is run from within WSL2, DNS needs to be disabled.

## Deploy the VM with Terraform
```bash
terraform plan -out main.tfplan
terraform apply "main.tfplan"

# Wait for it...

# Get the public IP:
terraform output public_ip_address

# Sign in via SSH.
```

## Additional installations

### VM
TODO: Add to provisioning script.

```bash
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

## Links

* Terraform instructions: https://docs.microsoft.com/en-us/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure
* https://www.terraform.io/downloads
* Terraform's Azure RM provider documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
* Passing custom data scripts to the VM: https://sbulav.github.io/terraform/terraform-azurerm-compute-custom-data/
