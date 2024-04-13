// pihole VM definition

module "pihole" {
  source    = "../proxmox-module"
  instances = 1

  pve_node_name  = "pve0"
  vm_name        = "pihole"
  vm_description = "PiHole Provisioned with Terraform"
  vm_tags        = ["terraform", "network"]

  vm_id               = 110
  vm_disk_size        = 6
  vm_memory_dedicated = 1024
  vm_nic              = "vmbr0"

  vm_on_boot = true

  # vm_startup = {
  #   order = "3"
  # }

  vm_image          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  vm_ssh_key        = "id_tiger.pub"
  vm_starship_theme = "nord-greenscreen"
}
