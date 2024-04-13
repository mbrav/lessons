variable "pve_node_name" {
  type        = string
  description = "Proxmox Virtual Environment Node Name"
}

# PVE Auth
variable "virtual_environment_endpoint" {
  type        = string
  description = "The endpoint for the Proxmox Virtual Environment API (example: https://10.0.0.2:8006/)"
}

variable "virtual_environment_token" {
  type        = string
  description = "Token for Proxmox Virtual Environment API (example: terraform@pve!provider=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)"
}

variable "vm_ssh_key" {
  type        = string
  description = "Define public SSH key for VM"
}
