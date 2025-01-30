# Dependency defintions

terraform {
  required_version = "~> 1.9"
  required_providers {
    # For documentation, refer to Terraform libvirt provider
    # https://github.com/dmacvicar/terraform-provider-libvirt
    libvirt = {
      version = "~> 0.8"
      source  = "dmacvicar/libvirt"
    }
  }
}
