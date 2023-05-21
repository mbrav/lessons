# Output varibales

output "vm_name" {
  description = "Name of the deployed VMs"
  value       = libvirt_domain.vm.*.name
}

output "vm_id" {
  description = "ID of the deployed VMs"
  value       = libvirt_domain.vm.*.id
}

output "vm_ipv4" {
  description = "IP address of the deployed VMs"
  # value       = [for vm in libvirt_domain.vm : vm.network_interface[0].addresses[0]]
  # value       = [for i, vm in libvirt_domain.vm : lookup(vm.network_interface[0].addresses, 0, i)]
  value       = [for ip in var.vm_ipv4 : ip]
}
