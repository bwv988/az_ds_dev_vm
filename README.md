# Azure Data Science development VM

Terraform scripts to spool up a Data Science dev box in Azure.

## Prerequisites

* Terraform and Azure CLI installed
* If this is run from within WSL2, DNS needs to be disabled as there is currently an issue in conjunction with Terraform
* The Terraform script assumes that an SSH key public key exists under `~/.ssh/id_rsa.pub`.

## Deploy the VM with Terraform
```bash
terraform init
az login
terraform plan -out main.tfplan
terraform apply "main.tfplan"

# Wait for it...

# Get the public IP:
terraform output public_ip_address

# Sign in via SSH.

ssh sral@<public ip address>
```

## TODO
[ ] Use Codespaces encrypted secrets: https://docs.github.com/en/codespaces/managing-your-codespaces/managing-encrypted-secrets-for-your-codespaces

## Usage

### On the VM
Run Jupyter lab:
```bash
jupyter lab
```

### Client
On the client, open an SSH tunnel to connect to JupyterLab:

```bash
ssh -N -L 8888:localhost:8888 {user]@{host}
```

Then point your browser to https://localhost:8888

## Links

* Terraform instructions: https://docs.microsoft.com/en-us/azure/developer/terraform/create-linux-virtual-machine-with-infrastructure
* https://www.terraform.io/downloads
* Terraform's Azure RM provider documentation: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
* Passing custom data scripts to the VM: https://sbulav.github.io/terraform/terraform-azurerm-compute-custom-data/
