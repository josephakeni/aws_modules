terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token 
  insecure = true
  ssh {
    agent       = true
    private_key = file("~/.ssh/id_rsa")
  }

}


resource "proxmox_virtual_environment_vm" "ubuntu_clone" {
  vm_id       = var.vm_id #400
  name        = var.vm_name
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
      keys = [file("./files/id_rsa.pub"), ]
    }

  }

  # force_create=true

}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.ubuntu_clone.ipv4_addresses[1][0]
}
