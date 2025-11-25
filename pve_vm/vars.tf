variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type = string
  default = "https://192.168.0.3:8006/api2/json"
}

variable "proxmox_token_id" {
  type = string
  default = "terraform@pam!terraform"
}

variable "proxmox_token_secret" {
  type = string
  default = "78cf6eac-e31d-4b83-ae1a-69bdf2956484"
}

variable "proxmox_tls_insecure" {
  type = bool
  sensitive = true
  default = true
}

variable "proxmox_node" {
  type = string
  default = "pve"
}

variable "vm_cores" {
  type = number
  default = 2
}

variable "vm_sockets" {
  type = number
  default = 1
}

variable "vm_memory" {
  type = number
  default = 2048
}

variable "vm_network_model" {
  type = string
  default = "virtio"
}

variable "vm_ci_user" {
  type = string
  default = "ubuntu"
}

variable "vm_ci_password" {
  type = string
  default = "ubuntu"
}

variable "vm_ssh_keys" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDC57bYGFpcQ4DQFLDK5bIFPiU5trl7vVpAux9aExkqN0ck1D7ZJlNzmmtGEOiw59sxOXuw/3XPP9riWNyESxQgsazjSBx4LyVhXGzIYqpBvLl5wI7vU6WqVNR+zlNAVYqQGqc6nGqBv9pP7bBVuez9ZyzCAA9CNBo8rdkns88+zH+z/OwHlTkop2Z8t71A6WFk53304NVYF0HnejXL2fMV8ncGpdvcs4I7u5fJZ4lfTpi0NYhz9JBozrulwcijGk1+R7I68XW/rwL0Ac2+bBxL6F9cc5+hXWJsMMCmEwZzo0hGqNVkoqAIs3mLLK4Tuq7bp/FxKlKhSnOvh2wx/T3XT2QoK6RUSs95XTINCFDAdbonmyQVI0Dlv7Nx9a/AYKHQZggcWLVRecrPS5Z1gUiP21UtzgOJ14UTUi6vRjv/szadNw/FNWIxepniTYZut9KZaApRLEsjgSw6KRpmXucpGs7jxf1KVi6NAEDgACLCOv9NmDtPKl+PAWzH5eLt8x8= josephakeni@gmail.com"
}

# Legacy variables (kept for backward compatibility)
variable "ssh_key_path" {
  description = "Path to SSH public key file (deprecated, use vm_ssh_keys)"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ip_gateway" {
  default = "192.168.0.1"
}

variable "vm_ip" {
  default = ""
}
variable "name" {
  default = "webserver"
}
variable "vm_ip_config" {
  default = "192.168.0.22"
}
variable "template_vm_id" {
  default = 9005
}
variable "vm_id" {
  default = 204
}
variable "private_key" {
  default = ""
}
variable "install_jenkins" {
  default = ""
}