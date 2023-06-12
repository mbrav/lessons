# Variable definitions


variable "hostname" {
  type        = string
  default     = "machine"
  description = "Specify vm's hostname"
}

variable "addresses" {
  type        = list(string)
  default     = ["10.10.10.10"]
  description = "Specify vm's IPv4 and IPv6 addresses"
}

variable "memory" {
  type        = number
  default     = 2048
  description = "Specify vm's RAM"
}

variable "vcpu" {
  type        = number
  default     = 2
  description = "Specify vm's number of virtual cores"
}

variable "network_name" {
  type        = string
  default     = "k8s_net"
  description = "Specify libvirt network name"
}

variable "network_dns_domain" {
  type        = string
  default     = "k8s.local"
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

