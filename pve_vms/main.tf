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

  started            = null
  reboot             = null
  reboot_after_update = null
  protection         = null
  bios               = null
  scsi_hardware      = null
  acpi               = null
  keyboard_layout    = null

  agent {
    # NOTE: The agent is installed and enabled as part of the cloud-init configuration in the template VM, see cloud-config.tf
    # The working agent is *required* to retrieve the VM IP addresses.
    # If you are using a different cloud-init configuration, or a different clone source
    # that does not have the qemu-guest-agent installed, you may need to disable the `agent` below and remove the `vm_ipv4_address` output.
    # See https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#qemu-guest-agent for more details.
    enabled = true
  }

  memory {
    dedicated = var.memory #768
  }

  cpu {
    cores        = var.cores #2
    type         = "x86-64-v2-AES"  # recommended for modern CPUs
    flags  = null  # ✅ avoid empty list bug
    sockets = 1
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
  on_boot = var.on_boot

}
