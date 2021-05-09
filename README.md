# terraform-proxmox-ubuntu2004

Terraform module intended to be used in combination with this [Packer Proxmox Ubuntu 20.04 template.](https://github.com/justin-p/packer-proxmox-ubuntu2004)

Module includes 2 ansible playbooks that are run on every Terraform apply.

- `fix_disk.yml` ensures if that LVM is automaticlly resized when the disk is enlarged by Terraform.
- `disable_cloud-init.yml` ensures cloud-init is and stays disabled once Terraform has deployed the VM.

## Example

```terraform
module "ubuntu_vm" {
  source = "github.com/justin-p/terraform-proxmox-ubuntu2004?ref=0.0.1"

  proxmox_endpoint      = "https://192.168.10.10:8006/"
  proxmox_username      = "root@pam"
  proxmox_password      = "password"
  vm_name               = "ubuntu2004-vm"
  vm_description        = "Ubuntu 2004 VM created by Terraform"
  clone_vm_id           = 105
  vm_ip_address         = "192.168.12.5"
  vm_gateway            = "192.168.12.254"
  network_device_bridge = "vmbr0"
  private_key_path      = "${path.root}/../../infra/keys/packer/ubuntu_template/id_ed25519_ubuntu_packer"
}

output "ubuntu_vm" {
  value     = module.ubuntu_vm.ubuntu_vm
}
```
