# Dependency defintions

terraform {
  required_version = ">= 0.13.4"
  required_providers {
    # For documentation, refer to Terraform libvirt provider
    # https://github.com/dmacvicar/terraform-provider-libvirt
    libvirt = {
      version = ">= 0.7.1"
      source  = "dmacvicar/libvirt"
    }
  }
}

# Define KVM settings

# Define Base Image
resource "libvirt_volume" "vm_image" {
  name   = "vm_image_${var.vm_hostname}"
  pool   = var.libvirt_pool
  source = var.vm_qcow_image
  format = "qcow2"
}

# Generated Cloud Init ISO image
resource "libvirt_cloudinit_disk" "cloud_image" {
  count = var.instances

  # Add index if count defined
  name = "cloud_image_${var.vm_hostname}${var.instances > 1 ? count.index + 1 : ""}.iso"

  # Load cloud_init script and pass variables 
  user_data = templatefile(
    "${path.module}/init/cloud_init.cfg",
    {
      hostname       = "${var.vm_hostname}${var.instances > 1 ? count.index + 1 : ""}",
      user           = var.vm_user,
      password       = var.vm_user_password,
      ssh_key        = var.vm_ssh_key
      dotfiles_v     = var.vm_dotfiles_v,
      starship_theme = var.vm_starship_theme
    }
  )

  # Load network config script
  network_config = templatefile("${path.module}/init/network_config.cfg", {})
  pool           = var.libvirt_pool
}

# VM storage disk
resource "libvirt_volume" "vm_volume" {
  count          = var.instances
  name           = "volume_${var.vm_hostname}${var.instances > 1 ? count.index + 1 : ""}"
  pool           = var.libvirt_pool
  base_volume_id = libvirt_volume.vm_image.id
  format         = "qcow2"
  size           = var.vm_disk_size * 1024 * 1024 * 1024
}

# VM
resource "libvirt_domain" "vm" {
  count  = var.instances
  name   = "${var.vm_hostname}${var.instances > 1 ? count.index + 1 : ""}"
  memory = var.vm_memory
  vcpu   = var.vm_vcpu

  # Mount cloud-init image
  cloudinit = libvirt_cloudinit_disk.cloud_image[count.index].id

  network_interface {
    network_name   = var.libvirt_network
    wait_for_lease = true
    addresses      = [var.vm_ipv4[count.index]]
  }

  disk {
    volume_id = libvirt_volume.vm_volume[count.index].id
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

  # Wait for ssh port to be ready with 120s timeout
  # provisioner "local-exec" {
  # interpreter = ["/bin/bash", "-c"]

  # command = <<-EOF
  # set -Ee -o pipefail
  # ipv4_address="${var.vm_ipv4[count.index]}"
  # vm_name="${self.name}"
  # echo "SSH port 22 check for $vm_name (IP $ipv4_address)"
  # nc -z -v -w 120 "$ipv4_address" 22
  # EOF
  # }
}

# resource "libvirt_network" "k_net" {
#   # the name used by libvirt
#   name = "k_net"
#   # mode can be: "nat" (default), "none", "route", "open", "bridge"
#   mode = "nat"
# 
#   # the domain used by the DNS server in this network
#   domain = "knet.local"
# 
#   #  list of subnets the addresses allowed for domains connected
#   addresses = ["10.10.10.0/24", "2001:db8:1001::0/64"]
# 
#   # Auto start network
#   autostart = true
# 
#   # dhcp settings
#   dhcp {
#     enabled = true
#   }
# 
#   # (Optional) DNS configuration
#   dns {
#     # (Optional, default false)
#     # Set to true, if no other option is specified and you still want to 
#     # enable dns.
#     enabled = true
#     # (Optional, default false)
#     # true: DNS requests under this domain will only be resolved by the
#     # virtual network's own DNS server
#     # false: Unresolved requests will be forwarded to the host's
#     # upstream DNS server if the virtual network's DNS server does not
#     # have an answer.
#     local_only = true
# 
#     # (Optional) one or more DNS forwarder entries.  One or both of
#     # "address" and "domain" must be specified.  The format is:
#     # forwarders {
#     #     address = "my address"
#     #     domain = "my domain"
#     #  } 
#     # 
# 
#     # (Optional) one or more DNS host entries.  Both of
#     # "ip" and "hostname" must be specified.  The format is:
#     # hosts  {
#     #     hostname = "my_hostname"
#     #     ip = "my.ip.address.1"
#     #   }
#     # hosts {
#     #     hostname = "my_hostname"
#     #     ip = "my.ip.address.2"
#     #   }
#     # 
# 
#     # (Optional) one or more static routes.
#     # "cidr" and "gateway" must be specified. The format is:
#     # routes {
#     #     cidr = "10.17.0.0/16"
#     #     gateway = "10.18.0.2"
#     #   }
#   }
