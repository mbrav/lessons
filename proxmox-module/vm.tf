# VM Definition

resource "proxmox_virtual_environment_vm" "vm" {
  count     = var.instances
  node_name = var.pve_node_name

  vm_id       = var.vm_id + count.index
  name        = "${var.vm_name}${var.instances > 1 ? count.index + 1 : ""}"
  description = var.vm_description
  tags        = var.vm_tags

  on_boot = var.vm_on_boot
  # startup = var.vm_startup

  disk {
    datastore_id = var.pve_vm_datastore_id
    file_id      = proxmox_virtual_environment_download_file.vm_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.vm_disk_size
  }

  memory {
    dedicated = var.vm_memory_dedicated
  }

  cpu {
    # Proxmox VE recomended
    type = "x86-64-v2-AES"
  }

  network_device {
    bridge = var.vm_nic
  }

  audio_device {
    enabled = false
  }

  operating_system {
    # Linux > 2.6
    type = "l26"
  }

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = false
  }

  tpm_state {
    datastore_id = var.pve_vm_datastore_id
    version      = "v2.0"
  }

  serial_device {}

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    # Managed by vustom Cloud Init
    # user_account {
    #   keys     = [file("~/.ssh/${var.vm_ssh_key}")]
    #   username = var.vm_user
    #   password = var.vm_user_password
    # }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config[count.index].id
  }
}
