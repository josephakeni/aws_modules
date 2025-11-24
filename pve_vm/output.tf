output "vm_id" {
  value = proxmox_virtual_environment_vm.ubuntu_clone.*.vm_id
}