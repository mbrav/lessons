# Define KVM settings
# For documentation, refer to Terraform libvirt provider
# https://github.com/dmacvicar/terraform-provider-libvirt

provider "libvirt" {
  ## Configuration options
  alias = "system"
  uri   = "qemu:///system"
}

provider "libvirt" {
  ## Configuration options
  #alias = "server"
  #uri   = "qemu+ssh://root@192.168.100.10/system"
}

# Define custom libvirt pool when necessary
# resource "libvirt_pool" "vmdisk-pool" {
#   name = "vmdisk-pool"
#   type = "dir"
#   path = "/home/user/vmdisks"
# }

# Definine Base image
resource "libvirt_volume" "debian11_image" {
  name = "debian11_image"
  # pool   = libvirt_pool.vmdisk-pool.name
  pool   = "default"
  source = "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2"
  format = "qcow2"
}
