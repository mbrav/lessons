## pihole VM definition

module "test" {
  source    = "../proxmox-module"
  instances = 2

  pve_node_name  = "pve0"
  vm_name        = "test"
  vm_description = "Test VM Provisioned with Terraform"
  vm_tags        = ["terraform", "test"]

  vm_id               = 1100
  vm_cpu_cores        = 2
  vm_disk_size        = 6
  vm_memory_dedicated = 2048
  vm_nic              = "vmbr0"

  # read 'Qemu guest agent' section, change to true only when ready
  vm_agent_enable = var.vm_agent_enable

  vm_on_boot = false
  # vm_startup = {
  #   order = "3"
  # }

  # vm_image          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  vm_image          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  vm_ssh_key        = "id_tiger.pub"
  vm_user_password  = var.vm_user_password
  vm_starship_theme = "greenscreen"
}
