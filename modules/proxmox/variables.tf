
# # PVE Auth
# variable "virtual_environment_endpoint" {
#   type        = string
#   description = "The endpoint for the Proxmox Virtual Environment API (example: https://10.0.0.2:8006/)"
# }
#
# variable "virtual_environment_token" {
#   type        = string
#   description = "Token for Proxmox Virtual Environment API (example: terraform@pve!provider=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)"
# }

# PVE settings

variable "pve_node_name" {
  type        = string
  description = "Proxmox Virtual Environment Node Name"
  default     = "pve"
}

variable "pve_datastore_id" {
  type        = string
  description = "Proxmox Virtual Environment datastore ID on which OS images will be stored"
  default     = "local"
}

variable "pve_vm_datastore_id" {
  type        = string
  description = "Proxmox Virtual Environment datastore ID on which VM disks will be stored"
  default     = "local-lvm"
}

# VM Variables
variable "instances" {
  type        = number
  default     = 1
  description = "Define number of instances you want deploy from the template."
}

variable "vm_name" {
  type        = string
  default     = "terraform"
  description = "Define VM base name"
}

variable "vm_description" {
  type        = string
  default     = "Provisioned by Terraform"
  description = "Provide a description of the VM"
}

variable "vm_tags" {
  type        = list(string)
  default     = ["terraform"]
  description = "Managed by Terraform"
}

variable "vm_id" {
  type        = number
  default     = 100
  description = "Define VM Id number"
}

variable "vm_cpu_cores" {
  type        = number
  default     = 1
  description = "Define number of vCPU cores"
}

variable "vm_disk_size" {
  type        = number
  default     = 8
  description = "Define VM Disk Size in GB"
}

variable "vm_memory_dedicated" {
  type        = number
  default     = 1024
  description = "Define VM Dedicated Memory in MB"
}

variable "vm_nic" {
  type        = string
  default     = "vmbr0"
  description = "Define VM Network Interface"
}

variable "vm_on_boot" {
  type        = bool
  default     = false
  description = "Define VM on boot startup option"
}

variable "vm_agent_enable" {
  type        = bool
  default     = false
  description = "Enable kvm agent monitoring"
}

variable "vm_startup" {
  type = map(any)
  default = {
    order      = "3"
    up_delay   = "10"
    down_delay = "10"
  }
  description = "Define VM Startup parameters"
}

# Cloud Init variables
variable "vm_image" {
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  description = "Define URL path to Cloud ISO image."
}

variable "vm_user" {
  type        = string
  default     = "deploy"
  description = "define virtual machine user."
}

variable "vm_user_password" {
  type        = string
  default     = "master"
  description = "Define virtual machine user password."
}

variable "vm_ssh_key" {
  type        = string
  default     = "id_rsa.pub"
  description = "Define public SSH key for VM"
}

variable "vm_dotfiles_v" {
  type        = string
  default     = "0.3.8"
  description = "Define dotfiles version: https://github.com/mbrav/dotfiles"
}

variable "vm_starship_theme" {
  type        = string
  default     = "default"
  description = "Define starship theme: https://github.com/mbrav/dotfiles/blob/main/dotfiles/.config/starship.toml"
}
