#  Libvirt variables

variable "libvirt_pool" {
  type        = string
  default     = "default"
  description = "Specify libvirt pool"
}

# VM variables

variable "vm_user" {
  type        = string
  default     = "deploy"
  description = "Define virtual machine user"
}

variable "vm_user_password" {
  type        = string
  default     = "master"
  description = "Define virtual machine user password"
}
