// pihole VM definition

module "k8s_masters" {
  source    = "../proxmox-module"
  instances = 1

  pve_node_name  = "pve0"
  vm_name        = "k8s-test-master"
  vm_description = "K8s master Provisioned with Terraform"
  vm_tags        = ["terraform", "k8s", "test"]

  vm_id               = 501
  vm_disk_size        = 12
  vm_memory_dedicated = 4096
  vm_nic              = "vmbr0"

  vm_on_boot = true

  # vm_startup = {
  #   order = "3"
  # }

  vm_image          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  vm_ssh_key        = "id_tiger.pub"
  vm_starship_theme = "nord-tan"
}

module "k8s_workers" {
  source    = "../proxmox-module"
  instances = 3

  pve_node_name  = "pve0"
  vm_name        = "k8s-test-worker"
  vm_description = "K8s Worker Provisioned with Terraform"
  vm_tags        = ["terraform", "k8s", "test"]

  vm_id               = 511
  vm_disk_size        = 24
  vm_memory_dedicated = 8192
  vm_nic              = "vmbr0"

  vm_on_boot = true

  # vm_startup = {
  #   order = "3"
  # }

  vm_image          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  vm_ssh_key        = "id_tiger.pub"
  vm_starship_theme = "nord-green"
}
