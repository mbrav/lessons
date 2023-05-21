# Define KVM settings
# For documentation, refer to Terraform libvirt provider
# https://github.com/dmacvicar/terraform-provider-libvirt

provider "libvirt" {
  ## Configuration options
  alias = "system"
  uri   = "qemu:///system"
}

# Definine Base image
resource "libvirt_volume" "debian11_image" {
  name   = "debian11_image"
  pool   = "default"
  source = "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2"
  format = "qcow2"
}
