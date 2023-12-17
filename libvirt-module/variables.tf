
# Variable definitions

# Provider variables

variable "libvirt_pool" {
  type        = string
  default     = "default"
  description = "Define libvirt pool."
}

variable "libvirt_network" {
  type        = string
  default     = "default"
  description = "Define libvirt network."
}

# VM variables 

variable "instances" {
  type        = number
  default     = 1
  description = "Define number of instances you want deploy from the template."
}

# VM Address lenght have to be equal to the number of instaces
variable "vm_ipv4" {
  type        = list(string)
  default     = ["10.10.10.10"]
  description = "Define vm's IPv4 addresses."
}

variable "vm_memory" {
  type        = number
  default     = 2048
  description = "Define vm's RAM in MB."
}

variable "vm_vcpu" {
  type        = number
  default     = 2
  description = "Define vm's number of virtual cores."
}

variable "vm_disk_size" {
  type        = number
  default     = 16
  description = "Define vm's storage disk in GB."
}

# Cloud Init variables

variable "vm_qcow_image" {
  type        = string
  default     = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
  description = "Define URL/ path to qcow image."
}

variable "vm_hostname" {
  type        = string
  default     = "master"
  description = "Define virtual machine hostname. Hostnamw is used as a prefix for all vms."
}

variable "vm_user" {
  type        = string
  default     = "deploy"
  description = "Define virtual machine user."
}

variable "vm_user_password" {
  type        = string
  default     = "master"
  description = "Define virtual machine user password."
}

variable "vm_root_password" {
  type        = string
  default     = "admin"
  description = "Define virtual machine user root password."
}

variable "vm_ssh_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJBjKHlr65+3hIG79U6vWW9kmBtRNo2jkcx3Ba0SAbCK mbrav_lessons_key"
  description = "Define private SSH key for virtual machine user password."
}

variable "vm_dotfiles_v" {
  type        = string
  default     = "0.3.3"
  description = "Define dotfiles version: https://github.com/mbrav/dotfiles"
}

variable "vm_starship_theme" {
  type        = string
  default     = "default"
  description = "Define starship theme: https://github.com/mbrav/dotfiles/blob/main/dotfiles/.config/starship.toml"
}
