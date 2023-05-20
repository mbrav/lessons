# Define Cloud init images
# For documentaiton refer to: https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown

# Cloud init configs
data "template_file" "user_data_m1" {
  template = file("${path.module}/init/cloud_init_m1.cfg")
}

data "template_file" "user_data_w1" {
  template = file("${path.module}/init/cloud_init_w1.cfg")
}

# Networking init config 
data "template_file" "network_config" {
  template = file("${path.module}/init/network_config.cfg")
}

# Cloud init disks
resource "libvirt_cloudinit_disk" "debian_cloud_m1" {
  name           = "debian_cloud_m1.iso"
  user_data      = data.template_file.user_data_m1.rendered
  network_config = data.template_file.network_config.rendered
  # pool           = libvirt_pool.vmdisk-pool.name
  pool = "default"
}

resource "libvirt_cloudinit_disk" "debian_cloud_w1" {
  name           = "debian_cloud_w1.iso"
  user_data      = data.template_file.user_data_w1.rendered
  network_config = data.template_file.network_config.rendered
  # pool           = libvirt_pool.vmdisk-pool.name
  pool = "default"
}

