# VM disk definition

resource "proxmox_virtual_environment_download_file" "vm_image" {
  content_type = "iso"
  datastore_id = var.pve_datastore_id
  node_name    = var.pve_node_name
  url          = var.vm_image
}

# Cloud config
resource "proxmox_virtual_environment_file" "cloud_config" {
  count        = var.instances
  content_type = "snippets"
  datastore_id = var.pve_datastore_id
  node_name    = var.pve_node_name


  source_raw {
    data = templatefile(
      "${path.module}/init/cloud-init.yaml",
      {
        hostname       = "${var.vm_name}${var.instances > 1 ? count.index + 1 : ""}",
        user           = var.vm_user,
        password       = var.vm_user_password,
        ssh_key        = file("~/.ssh/${var.vm_ssh_key}")
        dotfiles_v     = var.vm_dotfiles_v,
        starship_theme = var.vm_starship_theme
      }
    )
    file_name = "${var.vm_name}${var.instances > 1 ? count.index + 1 : ""}.cloud-config.yaml"
  }
}


