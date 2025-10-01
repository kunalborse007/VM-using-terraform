terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://10.10.1.201:8006/api2/json"
  pm_api_token_id     = "root@pam!grerfsfdads4353grhg"
  pm_api_token_secret = "47c9c76d-22a0-41d7-86ea-0d5bf30fffaa"
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "ubuntu_vm" {
  name        = "terraform-vm01"
  target_node = "pve"
  clone       = "Template-VM"

  cores       = 2
  sockets     = 1
  memory      = 2048

  disk {
    size    = "20G"
    type    = "scsi"
    storage = "local-lvm"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ciuser     = "ubuntu"
  cipassword = "password123"
  ipconfig0  = "ip=10.10.1.120/24,gw=10.10.1.1"
}

