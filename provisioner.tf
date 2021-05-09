resource "null_resource" "wait_for_ssh" {
  depends_on = [
    proxmox_virtual_environment_vm.ubuntu_vm
  ]

  # Ensure this task always runs
  triggers = {
    always_run = "${timestamp()}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${var.private_key_path}")
    host        = local.ip_address
    agent       = false
    timeout     = "60s"
  }

  # Waiting for server to accept SSH connections and cloud-init to finish
  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for ssh...'"
    ]
  }
}

resource "null_resource" "ansible" {
  depends_on = [
    null_resource.wait_for_ssh
  ]

  # Ensure this task always runs
  triggers = {
    always_run = "${timestamp()}"
  }

  # Resize disks using ansible
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${local.ip_address}, --user ubuntu --private-key ${var.private_key_path} ${path.module}/playbooks/fix_disk.yml"
  }

  # Disable cloud-init using ansible
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${local.ip_address}, --user ubuntu --private-key ${var.private_key_path} ${path.module}/playbooks/disable_cloud-init.yml"
  }
}
