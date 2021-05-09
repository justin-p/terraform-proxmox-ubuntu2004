# terraform-proxmox-ubuntu2004

Terraform module intended to be used in combination with this [Packer Proxmox Ubuntu 20.04 template.](https://github.com/justin-p/packer-proxmox-ubuntu2004)

Module includes 2 ansible playbooks that are run on every Terraform apply.

- `fix_disk.yml` ensures if that LVM is automaticlly resized when the disk is enlarged by Terraform.
- `disable_cloud-init.yml` ensures cloud-init is and stays disabled once Terraform has deployed the VM.
