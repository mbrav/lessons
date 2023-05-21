# Define Cloud init images
# For documentaiton refer to: https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown

# Cloud init installation

# Master 1
resource "libvirt_cloudinit_disk" "debian_cloud_m1" {
  name = "debian_cloud_m1.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init.cfg",
    {
      hostname          = "master1",
      user              = "node",
      arch              = "amd64",
      crio_os           = "Debian_11",
      kubelet_service_v = "v0.15.1",
      cni_plugins_v     = "v1.3.0",
      crictl_v          = "v1.27.0",
      crio_v            = "1.24",
      download_dir      = "/usr/local/bin",
      dotfiles_v        = "0.2.1",
      starship_theme    = "nord-green"
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  pool           = "default"
}

# Master 2
resource "libvirt_cloudinit_disk" "debian_cloud_m2" {
  name = "debian_cloud_m2.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init.cfg",
    {
      hostname          = "master2",
      user              = "node",
      arch              = "amd64",
      crio_os           = "Debian_11",
      kubelet_service_v = "v0.15.1",
      cni_plugins_v     = "v1.3.0",
      crictl_v          = "v1.27.0",
      crio_v            = "1.24",
      download_dir      = "/usr/local/bin",
      dotfiles_v        = "0.2.1",
      starship_theme    = "nord-green"
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  pool           = "default"
}

# Master 3
resource "libvirt_cloudinit_disk" "debian_cloud_m3" {
  name = "debian_cloud_m3.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init.cfg",
    {
      hostname          = "master3",
      user              = "node",
      arch              = "amd64",
      crio_os           = "Debian_11",
      kubelet_service_v = "v0.15.1",
      cni_plugins_v     = "v1.3.0",
      crictl_v          = "v1.27.0",
      crio_v            = "1.24",
      download_dir      = "/usr/local/bin",
      dotfiles_v        = "0.2.1",
      starship_theme    = "nord-green"
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  pool           = "default"
}

# Worker 1
resource "libvirt_cloudinit_disk" "debian_cloud_w1" {
  name = "debian_cloud_w1.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init.cfg",
    {
      hostname          = "worker1",
      user              = "node",
      arch              = "amd64",
      crio_os           = "Debian_11",
      kubelet_service_v = "v0.15.1",
      cni_plugins_v     = "v1.3.0",
      crictl_v          = "v1.27.0",
      crio_v            = "1.24",
      download_dir      = "/usr/local/bin",
      dotfiles_v        = "0.2.1",
      starship_theme    = "nord-tan"
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  pool           = "default"
}

# Worker 2
resource "libvirt_cloudinit_disk" "debian_cloud_w2" {
  name = "debian_cloud_w2.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init.cfg",
    {
      hostname          = "worker2",
      user              = "node",
      arch              = "amd64",
      crio_os           = "Debian_11",
      kubelet_service_v = "v0.15.1",
      cni_plugins_v     = "v1.3.0",
      crictl_v          = "v1.27.0",
      crio_v            = "1.24",
      download_dir      = "/usr/local/bin",
      dotfiles_v        = "0.2.1",
      starship_theme    = "nord-tan"
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  pool           = "default"
}

# Worker 3
resource "libvirt_cloudinit_disk" "debian_cloud_w3" {
  name = "debian_cloud_w3.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init.cfg",
    {
      hostname          = "worker3",
      user              = "node",
      arch              = "amd64",
      crio_os           = "Debian_11",
      kubelet_service_v = "v0.15.1",
      cni_plugins_v     = "v1.3.0",
      crictl_v          = "v1.27.0",
      crio_v            = "1.24",
      download_dir      = "/usr/local/bin",
      dotfiles_v        = "0.2.1",
      starship_theme    = "nord-tan"
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  pool           = "default"
}


