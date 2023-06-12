# Define KVM resources to create

# VM
resource "libvirt_cloudinit_disk" "debian_cloud_image" {
  name = "debian_cloud_image.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init_k8s.cfg",
    {
      hostname          = var.hostname,
      user              = "node",
      arch              = "amd64",
      crio_os           = "Debian_11",
      kubelet_service_v = "v0.15.1",
      cni_plugins_v     = "v1.3.0",
      crictl_v          = "v1.27.0",
      crio_v            = "1.24",
      download_dir      = "/usr/local/bin",
      dotfiles_v        = "0.2.2",
      starship_theme    = "nord-green"
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  pool           = "default"
}

resource "libvirt_volume" "vm_volume" {
  provider       = libvirt.system
  name           = "volume_${var.hostname}"
  pool           = "default"
  base_volume_id = libvirt_volume.debian12_image.id
  format         = "qcow2"
  size           = 17179869184 # 16GB
}

resource "libvirt_domain" "vm" {
  name   = "vm_${var.hostname}"
  memory = var.memory
  vcpu   = var.vcpu

  # Mount cloud-init image
  cloudinit = libvirt_cloudinit_disk.debian_cloud_image.id

  network_interface {
    network_name   = libvirt_network.kvm_net.id
    wait_for_lease = true
    addresses      = var.addresses
  }

  disk {
    volume_id = libvirt_volume.vm_volume.id
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
