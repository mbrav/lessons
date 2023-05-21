# Define provider
terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}

provider "libvirt" {
  ## Configuration options
  alias = "system"
  uri   = "qemu:///system"
}


resource "libvirt_network" "k_net" {
  # the name used by libvirt
  name = "k_net"
  # mode can be: "nat" (default), "none", "route", "open", "bridge"
  mode = "nat"

  # the domain used by the DNS server in this network
  domain = "knet.local"

  #  list of subnets the addresses allowed for domains connected
  addresses = ["10.10.10.0/24", "2001:db8:1001::0/64"]

  # Auto start network
  autostart = true

  # dhcp settings
  dhcp {
    enabled = true
  }

  # (Optional) DNS configuration
  dns {
    enabled    = true
    local_only = true
  }
}

module "masters" {
  # Define number of masters 
  instances       = 3
  source          = "../libvirt-module"
  libvirt_pool    = var.libvirt_pool
  libvirt_network = libvirt_network.k_net.name

  # VM Definition
  vm_hostname       = "master"
  vm_ipv4           = ["10.10.10.11", "10.10.10.12", "10.10.10.13"]
  vm_starship_theme = "nord-green"
  vm_memory         = 2048
  vm_vcpu           = 2
  vm_disk_size      = 12
}

module "workers" {
  # Define number of masters 
  instances       = 3
  source          = "../libvirt-module"
  libvirt_pool    = var.libvirt_pool
  libvirt_network = libvirt_network.k_net.name

  # VM Definition
  vm_hostname       = "worker"
  vm_ipv4           = ["10.10.10.21", "10.10.10.22", "10.10.10.23"]
  vm_starship_theme = "nord-tan"
  vm_memory         = 3072
  vm_vcpu           = 2
  vm_disk_size      = 16
}


# Generate Ansible inventory files
resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tpl",
    {
      timestamp        = timestamp()
      vm_masters       = module.masters.vm_name
      ip_masters       = module.masters.vm_ipv4
      vm_workers       = module.workers.vm_name
      ip_workers       = module.workers.vm_ipv4
      vm_root_user     = "root"
      vm_user          = var.vm_user
      vm_user_password = var.vm_user_password
    }
  )
  filename        = "ansible/inventory/k8s.yaml"
  file_permission = "0644"


  # # Run Ansible with generate inventory
  # provisioner "local-exec" {
  #   working_dir = "../../ansible"
  #   command     = "ansible-playbook -i inventory/k8s.yml --become --become-user=root --tags cluster"
  #   environment = {
  #     ANSIBLE_HOST_KEY_CHECKING = "False",
  #   }
  #   on_failure = fail
  # }
}
