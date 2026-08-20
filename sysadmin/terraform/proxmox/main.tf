terraform {
  required_version = ">= 1.15.8"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.111.1"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://192.168.0.2:8006/"
  api_token = "root@pam!terraform-token=e87e43ca-c311-4a6d-927d-5f53dfd69058"
  insecure  = true
}

# Ubuntu cloud
resource "proxmox_download_file" "ubuntu_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "proxmox"
  # Maybe I should not use current for reproducibility... for not it is fine
  url                 = "https://cloud-images.ubuntu.com/resolute/current/resolute-server-cloudimg-amd64.img"
  file_name           = "ubuntu-26.04-cloud-image.qcow2"
  upload_timeout      = 1800
  overwrite_unmanaged = true
  overwrite           = false
}

# Debian LCX
resource "proxmox_download_file" "debian_lcx_template" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "proxmox"
  # Same here, this build may not exist in the future
  url                 = "https://images.linuxcontainers.org/images/debian/trixie/amd64/default/20260723_05:24/rootfs.tar.xz"
  file_name           = "debian-13-lcx-template.tar.xz"
  overwrite_unmanaged = true
  overwrite           = false
}

# Windows server
resource "proxmox_download_file" "windows_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "proxmox"
  url                 = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso"
  file_name           = "virtio-win.iso"
  upload_timeout      = 1800
  overwrite_unmanaged = true
}


# Virtual machines
# ----------------

resource "proxmox_virtual_environment_vm" "kube_server_a" {
  name      = "kube-01"
  node_name = "proxmox"
  vm_id     = 201

  # Qemu agent
  agent {
    # enabled = true

    # Temporary fix
    wait_for_ip {
      disabled = true
    }
  }

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 8092
  }

  disk {
    datastore_id = "local-lvm"
    import_from  = proxmox_download_file.ubuntu_cloud_image.id
    interface    = "scsi0"
    size         = 100  # GB
    discard      = "on" # ???
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.0.201/24"
        gateway = "192.168.0.1"
      }
    }

    user_account {
      username = "sysadmin"
      password = "sysadmin"
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINvfOk4ha88xLG1Q2u0+Eu7umZhGt6fXyBGcqcDB3I9a sysadmin@kube-server-a"]
    }
  }
}

resource "proxmox_virtual_environment_vm" "windows_vm" {
  name      = "windows-01"
  node_name = "proxmox"
  vm_id     = 203

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 8092
  }

  disk {
    datastore_id = "local-lvm"
    import_from  = proxmox_download_file.windows_image.id
    interface    = "scsi0"
    size         = 100  # GB
    discard      = "on" # ???
  }

  network_device {
    bridge = "vmbr0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.0.203/24"
        gateway = "192.168.0.1"
      }
    }

    user_account {
      username = "sysadmin"
      password = "sysadmin"
    }
  }
}

# LCX Containers
# --------------

resource "proxmox_virtual_environment_container" "reverse_proxy" {
  node_name    = "proxmox"
  vm_id        = 202
  unprivileged = true

  initialization {
    hostname = "proxy-01"

    ip_config {
      ipv4 {
        address = "192.168.0.202/24"
        gateway = "192.168.0.1"
      }
    }

    user_account {
      password = "sysadmin"
      keys     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINvfOk4ha88xLG1Q2u0+Eu7umZhGt6fXyBGcqcDB3I9a sysadmin@reverse_proxy"]
    }
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }

  operating_system {
    template_file_id = proxmox_download_file.debian_lcx_template.id
    type             = "debian"
  }

  disk {
    datastore_id = "local-lvm"
    size         = 8
  }

  features {
    nesting = true
  }
}
