#  Libvirt variables

variable "libvirt_provider" {
  type        = string
  default     = "system"
  description = "Specify libvirt alias"
}

variable "libvirt_pool" {
  type        = string
  default     = "default"
  description = "Specify libvirt pool"
}

variable "libvirt_network" {
  type        = string
  default     = "default"
  description = "Specify libvirt network"
}

# Network variables

variable "network_name" {
  type        = string
  default     = "k8s_net"
  description = "Specify libvirt network name"
}

variable "network_dns_domain" {
  type        = string
  default     = "libvirt.local"
  description = "Specify libvirt network dns domain name"
}

variable "network_ipv4_cidr" {
  # ipv4: 10.10.10.0 - 10.10.10.254
  type        = string
  default     = "10.10.10.0/24"
  description = "Specify IPv4 network CIDR for libvirt network"
}

variable "network_ipv6_cidr" {
  # ipv6: 2001:db8:1001:0:0:0:0:0 - 2001:db8:1001:0:ffff:ffff:ffff:ffff
  type        = string
  default     = "2001:db8:1001::0/64"
  description = "Specify IPv6 network CIDR for libvirt network"
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
