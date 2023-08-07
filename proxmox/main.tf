terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.8"
    }
  }
}

resource "proxmox_vm_qemu" "server" {
  count = var.instance_count
  name = "${var.server_name}${count.index + 1}"
  target_node = var.target_node 
  vmid = "${var.prefix_vmid + count.index + 1}"
  clone = var.template_name 
  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  ciuser = var.ciuser
  cipassword = var.cipassword
  memory = var.memory_ram #4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  onboot = var.onboot_start
  disk {
    slot = 0
    size = var.disk_size #"10G"
    type = "scsi"
    storage = "local-lvm"
    #storage_type = "lvmpool"
    iothread = 1
  }
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  
  # network {
  #   model = "virtio"
  #   bridge = "vmbr17"
  # }
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  ipconfig0 = "ip=192.168.0.${var.static_ip_prefix + count.index + 1}/24,gw=192.168.0.1"
  # ipconfig1 = "ip=10.17.0.4${count.index + 1}/24"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
  
}
