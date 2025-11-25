locals {
  # vm_tags = join(";", ["docker", "terraform"])
  vm_tags = ["docker", "terraform"]
}


resource "proxmox_virtual_environment_vm" "ubuntu_clone" {
  name      = var.name
  node_name   = var.proxmox_node
  vm_id       = var.vm_id

  clone {
    vm_id = var.template_vm_id #9005 #local.template_vm_id
    full  = true
  }

  started  = true
  description = "Managed by Terraform ${random_id.randomname.hex}"

  cpu {
    cores   = var.vm_cores
    sockets = var.vm_sockets
  }

  memory {
    dedicated = var.vm_memory
  }

  agent {
    enabled = false
  }

  network_device {
    bridge = "vmbr0"
    model  = var.vm_network_model
  }

  
  # Cloud-Init Configuration
  initialization {
    user_account {
      username = var.vm_ci_user
      password = var.vm_ci_password
      keys     = var.vm_ssh_keys != "" ? [file(var.ssh_key_path)] : []
    }

    ip_config {
      ipv4 {
        # address = "${var.vm_ip}/24"
        address ="${var.vm_ip}/24" != "" && "${var.vm_ip}/24" != "ip=dhcp" ? split(",", "${var.vm_ip}/24")[0] : "dhcp"
        gateway = var.ip_gateway
      }
    }

    # user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  # Prevent Terraform from constantly trying to update cloud-init fields
  lifecycle {
    ignore_changes = [
      initialization,
    ]
  }
  on_boot = true
  # tags        = ["terraform", "ubuntu"]
  tags = local.vm_tags

  connection {
    type = "ssh"
    user = var.vm_ci_user
    # private_key = file("${pathexpand("~/.ssh/id_rsa")}") #file("~/.ssh/id_rsa") #file(var.ssh_private_key_path)
    private_key = file(pathexpand("${var.private_key}"))
    host        = var.vm_ip
    timeout     = "2m"
  }
  provisioner "file" {
    source      = "${path.module}/scripts/install-jenkins.sh"
    destination = "/tmp/install-jenkins.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-jenkins.sh",
      "sudo /tmp/install-jenkins.sh"
    ]


  }

}

resource "random_id" "randomname" {
  byte_length = 16
}





















# resource "proxmox_vm_qemu" "resource-name" {
#   count       = 1
#   name        = "VM-name"
#   target_node = "pve"
#   #   iso         = "ISO file name"
#   # or
#   clone = "packer-ubuntu-2004-20251030164731"
#   # cpu { cores = 2}
#   # basic VM settings here. agent refers to guest agent
#   # os_type = "cloud-init"
#   memory = 2048
#   # scsihw = "virtio-scsi-pci"
#   # bootdisk = "scsi0"
#   # ipconfig0 = "ip=192.168.0.12/24,gw=192.168.0.1"
#   # sshkeys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDC57bYGFpcQ4DQFLDK5bIFPiU5trl7vVpAux9aExkqN0ck1D7ZJlNzmmtGEOiw59sxOXuw/3XPP9riWNyESxQgsazjSBx4LyVhXGzIYqpBvLl5wI7vU6WqVNR+zlNAVYqQGqc6nGqBv9pP7bBVuez9ZyzCAA9CNBo8rdkns88+zH+z/OwHlTkop2Z8t71A6WFk53304NVYF0HnejXL2fMV8ncGpdvcs4I7u5fJZ4lfTpi0NYhz9JBozrulwcijGk1+R7I68XW/rwL0Ac2+bBxL6F9cc5+hXWJsMMCmEwZzo0hGqNVkoqAIs3mLLK4Tuq7bp/FxKlKhSnOvh2wx/T3XT2QoK6RUSs95XTINCFDAdbonmyQVI0Dlv7Nx9a/AYKHQZggcWLVRecrPS5Z1gUiP21UtzgOJ14UTUi6vRjv/szadNw/FNWIxepniTYZut9KZaApRLEsjgSw6KRpmXucpGs7jxf1KVi6NAEDgACLCOv9NmDtPKl+PAWzH5eLt8x8= josephakeni@gmail.com"
#   tags = local.vm_tags #"docker; terraform"
# }
