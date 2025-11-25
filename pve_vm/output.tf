output "vm_ids" {
  value = proxmox_virtual_environment_vm.ubuntu_template[*].vm_id
}