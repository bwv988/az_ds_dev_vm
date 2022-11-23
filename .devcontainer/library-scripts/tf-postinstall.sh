#!/usr/bin/env bash

set -e 

echo -e "Running Terraform init and upgrade..."

terraform init -upgrade

echo -e "Done!"