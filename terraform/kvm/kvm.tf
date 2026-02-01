terraform {
	required_providers {
		libvirt = {
			source  = "dmacvicar/libvirt"
      version = "0.9.2"
		}
	}
}

provider "libvirt" {
	uri = "qemu:///system"
}

resource "libvirt_pool" "lab_storage" {
  name = "default"
  type = "dir"
  target = {
    path = "/var/lib/libvirt/images"
  }
}

# Create a virtual disk from a local image or URL
resource "libvirt_volume" "ubuntu_qcow2" {
  name   = "ubuntu-disk.qcow2"
  pool   = libvirt_pool.lab_storage.name

  target = {
    format = {
      type = "qcow2"
    }
  }

  create = {
    content = {
      url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
    }
  }
}

# Define the virtual machine
resource "libvirt_domain" "ubuntu_vm" {
  name   = "lab-server-01"
  memory = "2048"
  vcpu   = 2
  type   = "kvm"

  os = {
    type         = "hvm"
    type_arch    = "x86_64"
    type_machine = "q35"
  }

  devices = {
    interfaces = [{
      type = "network"
      model = {
        type = "virtio"
      }
      source = {
        network = {
          network = "default"
        }
      }
    }]

    disks = [{
      source = {
        volume = { 
          pool   = libvirt_volume.ubuntu_qcow2.pool
          volume = libvirt_volume.ubuntu_qcow2.name
        }
      }

      target = {
        dev = "vda"
        bus = "virtio"
      }

      driver = {
        type = "qcow2"
      }
    }]

    consoles = [{
      type        = "pty"
      target_port = "0"
      target_type = "serial"
    }]
  }
}
