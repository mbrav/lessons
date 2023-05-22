# Define KVM resources to create

# Master 1
resource "libvirt_cloudinit_disk" "debian_cloud_master_1" {
  name = "debian_cloud_master_1.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init_k8s.cfg",
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

resource "libvirt_volume" "kubernetes_master_1_disk" {
  provider       = libvirt.system
  name           = "kubernetes_master_1"
  pool           = "default"
  base_volume_id = libvirt_volume.debian11_image.id
  format         = "qcow2"
  size           = 17179869184 # 16GB
}

resource "libvirt_domain" "kubernetes_master_1" {
  name   = "kubernetes_master_1"
  memory = "3072"
  vcpu   = 2

  # Mount cloud-init image
  cloudinit = libvirt_cloudinit_disk.debian_cloud_master_1.id

  network_interface {
    network_name   = "k8s_net"
    wait_for_lease = true
    addresses      = ["10.10.10.11"]
  }

  disk {
    volume_id = libvirt_volume.kubernetes_master_1_disk.id
  }

  # Serial TTY
  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  # VirtIO TTY
  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  # Graphics Output
  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
