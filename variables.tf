variable "proxmox_endpoint" {
  type    = string
  default = "https://192.168.10.10:8006/"
}

variable "proxmox_username" {
  type    = string
  default = "root@pam"
}

variable "proxmox_password" {
  type    = string
  default = "password"
}

variable "proxmox_insecure" {
  type    = string
  default = true
}

variable "vm_name" {
  type    = string
  default = "terraform-provider-proxmox-ubuntu-vm"
}

variable "vm_description" {
  type    = string
  default = "Managed by Terraform"
}

variable "node_name" {
  type    = string
  default = "proxmox"
}

variable "agent_status" {
  type    = bool
  default = true
}

variable "clone_vm_id" {
  type    = string
  default = 105
}

variable "disk_datastore_id" {
  type    = string
  default = "local-lvm"
}

variable "disk_interface" {
  type    = string
  default = "virtio0"
}

variable "disk_size" {
  type    = string
  default = "15"
}

variable "vm_ip_address" {
  type    = string
  default = "10.11.12.1"
}

variable "vm_subnet" {
  type    = string
  default = "/24"
}

locals {
  cidr = "${var.vm_ip_address}${var.vm_subnet}"
}

variable "vm_gateway" {
  type    = string
  default = "10.11.12.254"
}

variable "network_device_bridge" {
  type    = string
  default = "vmbr0"
}

variable "operating_system_type" {
  type    = string
  default = "l26"
}

variable "private_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519"
}

locals {
  ip_address = element(element(proxmox_virtual_environment_vm.ubuntu_vm.ipv4_addresses, 1), length(proxmox_virtual_environment_vm.ubuntu_vm.ipv4_addresses) - 1)
}
