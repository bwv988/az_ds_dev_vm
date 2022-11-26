#!/usr/bin/env bash

set -e 

echo -e "Running Terraform init and upgrade..."

cd /workspaces/az_ds_dev_vm
terraform init -upgrade

echo -e "Done!"