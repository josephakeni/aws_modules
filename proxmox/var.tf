variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDC57bYGFpcQ4DQFLDK5bIFPiU5trl7vVpAux9aExkqN0ck1D7ZJlNzmmtGEOiw59sxOXuw/3XPP9riWNyESxQgsazjSBx4LyVhXGzIYqpBvLl5wI7vU6WqVNR+zlNAVYqQGqc6nGqBv9pP7bBVuez9ZyzCAA9CNBo8rdkns88+zH+z/OwHlTkop2Z8t71A6WFk53304NVYF0HnejXL2fMV8ncGpdvcs4I7u5fJZ4lfTpi0NYhz9JBozrulwcijGk1+R7I68XW/rwL0Ac2+bBxL6F9cc5+hXWJsMMCmEwZzo0hGqNVkoqAIs3mLLK4Tuq7bp/FxKlKhSnOvh2wx/T3XT2QoK6RUSs95XTINCFDAdbonmyQVI0Dlv7Nx9a/AYKHQZggcWLVRecrPS5Z1gUiP21UtzgOJ14UTUi6vRjv/szadNw/FNWIxepniTYZut9KZaApRLEsjgSw6KRpmXucpGs7jxf1KVi6NAEDgACLCOv9NmDtPKl+PAWzH5eLt8x8= josephakeni@gmail.com"
}

variable "proxmox_host" {
  default = "pve"
}

variable "template_name" {
  default = "packer-test"
}

variable "proxmox_api_url" {
  default = "https://192.168.0.3:8006/api2/json"
}

variable "proxmox_api_token" {
  type        = string
  default     = "terraform@pam!terraform=78cf6eac-e31d-4b83-ae1a-69bdf2956484"
  description = "description"
}


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