locals {
  ubuntu_vm = {
    vm_name        = var.vm_name
    vm_description = var.vm_description    
    ip_address     = local.ip_address

  }
}

output "ubuntu_vm" {
  value       = local.ubuntu_vm
  description = "Information about the created ubuntu VM."
}
