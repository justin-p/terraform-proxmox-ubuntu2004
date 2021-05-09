# https://registry.terraform.io/providers/danitso/proxmox/latest
terraform {
  required_providers {
    proxmox = {
      source  = "danitso/proxmox"
      version = "0.4.4"
    }
  }
}

provider "proxmox" {
  virtual_environment {
    endpoint = var.proxmox_endpoint
    username = var.proxmox_username
    password = var.proxmox_password
    insecure = var.proxmox_insecure
  }
}
