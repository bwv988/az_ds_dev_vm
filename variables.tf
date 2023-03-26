# Variable definitions.

variable "resource_group_name_prefix" {
  default       = "rg"
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resource_group_location" {
  default       = "northeurope"
  description   = "Location of the resource group."
}

# Use the below command to list all VM sizes for the respective zone:
#
# az vm list-sizes --location northeurope
#
# Standard_E8-2ads_v5 - 2 vCPUs, 64GB RAM.
variable "vm_size" {
  #default       = "Standard_D2s_v3"
  default = "Standard_E8-2ads_v5"
  description   = "VM size to deploy."
}