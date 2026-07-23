# Proxmox

## Packer

First download the ubuntu image on proxmox

```
proxmox -> local -> ISO Images -> Download from URL
https://releases.ubuntu.com/26.04/ubuntu-26.04-live-server-amd64.iso
```

After creating a proxmox token (see ubuntu.pkr.hcl file), run:

```bash
packer init -var-file='ubuntu-variables.pkr.hcl' ubuntu.pkr.hcl
packer validate -var-file='ubuntu-variables.pkr.hcl' ubuntu.pkr.hcl
packer build -var-file='ubuntu-variables.pkr.hcl' ubuntu.pkr.hcl
```

## Terraform

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```
