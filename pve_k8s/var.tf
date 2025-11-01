
variable "proxmox_host" {
  default = "pve"
}

variable "template_name" {
  default = "packer-test"
}

variable "proxmox_api_url" {}

variable "proxmox_api_token" {}
variable "vm_name" {}


variable "pm_tls_insecure" {
  type        = bool
  default     = true
  description = "pm_tls_insecure"
}

variable "proxmox_node" {
  default = "pve"
}

variable "vm_id" {}
variable "vmid_ip_suffix" {}
variable "ip_gateway" {
  default = "192.168.0.1"
}
variable "on_boot" {}
variable "clone_vm_id" {}
variable "memory" {}
variable "cores" {}