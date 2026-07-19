# Variable definitions

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_username" {
    type = string
}

variable "proxmox_ssh_username" {
    type = string
}

variable "proxmox_ssh_password" {
    type = string
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

packer {
    required_plugins {
        proxmox = {
            version = ">= 1.2.3"
            source  = "github.com/hashicorp/proxmox"
        }
    }
}

source "proxmox-iso" "ubuntu-server" {
    proxmox_url              = "${var.proxmox_api_url}"
    username                 = "${var.proxmox_api_username}"
    ssh_username             = "${var.proxmox_ssh_username}"
    ssh_password             = "${var.proxmox_ssh_password}"

    # To create the token, go to the proxmox web page and to
    # Datacenter -> API Tokens -> Add
    # Then set user, token ID and check "Privilege Separation"
    #
    # Alternatively you can use the cli:
    #    pveum user token add root@pam automation --privsep 1
    #
    # Either way, if you enabled privilege separation, you need to give
    # permissions to modify resources in the proxmox host:
    #     pveum acl modify / -role Administrator -token 'root@pam!automation'
    token                    = "${var.proxmox_api_token_secret}"

    insecure_skip_tls_verify = true

    node                 = "proxmox"
    vm_name              = "ubuntu-2604-template"
    template_name        = "packer-ubuntu2604"
    template_description = "Packet template"
    ssh_timeout          = "20m"

    boot_iso {
        type     = "scsi"
        # Can also be iso_irl + iso_storage_pool
        iso_file = "local:iso/ubuntu-26.04-live-server-amd64.iso"
        unmount  = true
       # TODO: iso_checksum = "..."
    }
    # boot_iso {
    #     iso_url = "https://releases.ubuntu.com/26.04/ubuntu-26.04-live-server-amd64.iso"
    #     iso_checksum = "dec49008a71f6098d0bcfc822021f4d042d5f2db279e4d75bdd981304f1ca5d9"
    #     iso_storage_pool = "local"
    # }

    cores  = 2
    memory = 4096

    network_adapters {
        model = "virtio"
        bridge = "vmbr0"
        firewall = "false"
    }

    disks {
        disk_size = "100G"
        format = "raw"
        storage_pool = "local-lvm"
        type = "virtio"
    }

    qemu_agent   = true
    scsi_controller = "virtio-scsi-pci"
    cloud_init = true
    cloud_init_storage_pool = "local-lvm"

    # Run automated OS install
    http_directory = "http"
    http_bind_address = "192.168.0.72"
    boot_command = [
        "<esc><wait>",
        "e<wait>",
        "<down><down><down><end>",
        "<bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
    ]
    boot = "c"
}

build {
    sources = ["source.proxmox-iso.ubuntu-server"]

    # provisioner "shell" {
    #     inline = [
    #         "sudo apt-get update",
    #         "sudo apt-get install -y qemu-guest-agent",
    #         "sudo systemctl enable qemu-guest-agent"
    #     ]
    # }

    # Todo, use ansible instead of "shell"
    # provisioner "ansible" {
    #   playbook_file = "./playbooks/baseline.yml"
    # }

    provisioner "shell" {
        inline = [
            "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
            "sudo rm /etc/ssh/ssh_host_*",
            "sudo truncate -s 0 /etc/machine-id",
            "sudo apt -y autoremove --purge",
            "sudo apt -y clean",
            "sudo apt -y autoclean",
            "sudo cloud-init clean",
            "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
            "sudo rm -f /etc/netplan/00-installer-config.yaml",
            "sudo sync"
        ]
    }
}
