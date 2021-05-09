resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name        = var.vm_name
  description = var.vm_description

  node_name = var.node_name

  agent {
    enabled = var.agent_status
  }

  clone {
    vm_id = var.clone_vm_id
  }

  disk {
    datastore_id = var.disk_datastore_id
    interface    = var.disk_interface
    size         = var.disk_size
  }

  initialization {
    ip_config {
      ipv4 {
        address = local.cidr
        gateway = var.vm_gateway
      }
    }

    user_account {
      username = "ubuntu"
      password = random_password.ubuntu_vm_password.result
    }
  }
  
  network_device {
    bridge = var.network_device_bridge
  }

  operating_system {
    type = var.operating_system_type
  }
}

resource "random_password" "ubuntu_vm_password" {
  length           = 32
  override_special = "_%@"
  special          = true
}
