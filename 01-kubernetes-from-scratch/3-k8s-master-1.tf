# Define KVM resources to create

resource "libvirt_volume" "k8s_master_1_disk" {
  provider = libvirt.system
  name     = "k8s_master_1"
  # pool           = libvirt_pool.vmdisk-pool.name
  pool           = "default"
  base_volume_id = libvirt_volume.debian11_image.id
  format         = "qcow2"
  size           = 17179869184 # 16GB
}

resource "libvirt_domain" "k8s_master_1" {
  name   = "k8s_master_1"
  memory = "3072"
  vcpu   = 2

  # Mount cloud-init image
  cloudinit = libvirt_cloudinit_disk.debian_cloud_m1.id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.k8s_master_1_disk.id
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
