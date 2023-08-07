variable "pm_tls_insecure" {
  type = bool
  default = true
  description = "pm_tls_insecure"
}

variable "template_name" {
    default = "ubuntu-2004-cloudinit-template"
}

variable "api_url" {}
variable token_secret {}
variable "api_token_id" {}
variable "ssh_key" {}
variable memory_ram {}
variable "disk_size" {}
variable "target_node" {}
variable "prefix_vmid" {}
variable "static_ip_prefix" {}
variable "instance_count" {}
variable "server_name" {}
variable cipassword {}
variable ciuser {}
variable "onboot_start" {}