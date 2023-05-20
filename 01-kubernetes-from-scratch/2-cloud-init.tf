# Define Cloud init images
# For documentaiton refer to: https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown

# Cloud init disks
resource "libvirt_cloudinit_disk" "debian_cloud_m1" {
  name = "debian_cloud_m1.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init.cfg",
    {
      hostname       = "master1",
      user           = "node",
      crio_os        = "Debian_11",
      crio_v         = "1.24",
      dotfiles_v     = "0.2.0",
      starship_theme = "nord-green"
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  # pool           = libvirt_pool.vmdisk-pool.name
  pool = "default"
}

resource "libvirt_cloudinit_disk" "debian_cloud_w1" {
  name = "debian_cloud_w1.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init.cfg",
    {
      hostname       = "worker1",
      user           = "node",
      crio_os        = "Debian_11",
      crio_v         = "1.24",
      dotfiles_v     = "0.2.0",
      starship_theme = "nord-tan"
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  # pool           = libvirt_pool.vmdisk-pool.name
  pool = "default"
}

