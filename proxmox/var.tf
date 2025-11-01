
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

variable "vm_id" {
  default = 400
}
variable "vmid_ip_suffix" {
  default = 63
}
variable "ip_gateway" {
  default = "192.168.0.1"
}

variable "instance_count" {
  default = 1
}
variable "kmaster" {
  default = "k8s-master-"
}
variable "kworker" {
  default = "k8s-node-"
}

variable "memory_ram_master" {
  type        = number
  default     = 8192
  description = "description"
}

variable "ciuser" {
  type        = string
  default     = "ubuntu"
  description = "description"
}
variable "cipassword" {
  type        = string
  default     = "ubuntu"
  description = "description"
}
variable "onboot_start" {
  type        = string
  default     = "false"
  description = "Start at boot"
}
variable "clone_vm_id" {
  type        = number
  default     = 9001
}