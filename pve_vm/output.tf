output "vm_ids" {
  value = proxmox_virtual_environment_vm.ubuntu_clone.vm_id
}
output "vm_ip" {
  value = var.vm_ip
}