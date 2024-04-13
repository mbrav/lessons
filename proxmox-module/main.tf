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

# provider "proxmox" {
#   endpoint  = var.virtual_environment_endpoint
#   api_token = var.virtual_environment_token
#   insecure  = true
#   ssh {
#     agent    = true
#     username = "root"
#   }
# }
