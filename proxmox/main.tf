terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url #"https://192.168.0.3:8006/api2/json"
  api_token = var.proxmox_api_token #"terraform@pam!terraform=78cf6eac-e31d-4b83-ae1a-69bdf2956484"
  insecure = true
  ssh {
    agent       = true
    private_key = file("~/.ssh/id_rsa")
  }

}


resource "proxmox_virtual_environment_vm" "ubuntu_clone" {
  vm_id       = var.vm_id #400
  name        = "k8s-ubuntu-clone"
  node_name   = var.proxmox_node #"pve" #var.virtual_environment_node_name
  description = "Managed by Terraform"
  tags        = ["terraform", "ubuntu"]

  clone {
    vm_id = var.clone_vm_id #9001 #proxmox_virtual_environment_vm.ubuntu_template.id
    full  = true
  }

  agent {
    # NOTE: The agent is installed and enabled as part of the cloud-init configuration in the template VM, see cloud-config.tf
    # The working agent is *required* to retrieve the VM IP addresses.
    # If you are using a different cloud-init configuration, or a different clone source
    # that does not have the qemu-guest-agent installed, you may need to disable the `agent` below and remove the `vm_ipv4_address` output.
    # See https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#qemu-guest-agent for more details.
    enabled = true
  }

  memory {
    dedicated = 768
  }

  initialization {
    dns {
      servers = ["1.1.1.1"]
    }
    ip_config {
      ipv4 {
        address = "192.168.0.${var.vmid_ip_suffix}/24"
        gateway = var.ip_gateway
      }
    }
    user_account {
      keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDC57bYGFpcQ4DQFLDK5bIFPiU5trl7vVpAux9aExkqN0ck1D7ZJlNzmmtGEOiw59sxOXuw/3XPP9riWNyESxQgsazjSBx4LyVhXGzIYqpBvLl5wI7vU6WqVNR+zlNAVYqQGqc6nGqBv9pP7bBVuez9ZyzCAA9CNBo8rdkns88+zH+z/OwHlTkop2Z8t71A6WFk53304NVYF0HnejXL2fMV8ncGpdvcs4I7u5fJZ4lfTpi0NYhz9JBozrulwcijGk1+R7I68XW/rwL0Ac2+bBxL6F9cc5+hXWJsMMCmEwZzo0hGqNVkoqAIs3mLLK4Tuq7bp/FxKlKhSnOvh2wx/T3XT2QoK6RUSs95XTINCFDAdbonmyQVI0Dlv7Nx9a/AYKHQZggcWLVRecrPS5Z1gUiP21UtzgOJ14UTUi6vRjv/szadNw/FNWIxepniTYZut9KZaApRLEsjgSw6KRpmXucpGs7jxf1KVi6NAEDgACLCOv9NmDtPKl+PAWzH5eLt8x8= josephakeni@gmail.com", ]
    }

  }

  # force_create=true

}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.ubuntu_clone.ipv4_addresses[1][0]
}

# resource "proxmox_vm_qemu" "server" {
#   count       = var.instance_count
#   name        = "tunde-${count.index + 1}"
#   target_node = var.target_node
#   vmid        = var.prefix_vmid + count.index + 1
#   clone       = var.template_name
#   full_clone = true


# agent       = 1
# os_type     = "cloud-init"

# cpu {cores       = 2}
# # sockets     = 1
# # cpu_type         = "host"
# memory      =  4096
# scsihw      = "virtio-scsi-pci"
# bootdisk    = "scsi0"
# onboot      = var.onboot_start

# ciuser      = var.ciuser
# cipassword  = var.cipassword


# ipconfig0 = "ip=192.168.0.61/24,gw=192.168.0.1"

# sshkeys = <<EOF
# ${var.ssh_key}
# EOF



# }
