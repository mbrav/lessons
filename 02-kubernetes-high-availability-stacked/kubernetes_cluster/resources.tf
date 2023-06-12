# Define KVM settings
# For documentation, refer to Terraform libvirt provider
# https://github.com/dmacvicar/terraform-provider-libvirt

# Definine Base image
resource "libvirt_volume" "debian12_image" {
  name   = "debian12_image"
  pool   = "default"
  source = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
  format = "qcow2"
}
