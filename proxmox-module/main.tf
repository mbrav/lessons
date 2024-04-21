// Provider defenitions

terraform {
  required_version = ">= 1.4.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.53.1"
    }
  }
}

