# Terraform

Terraform is a tool that lets you do "Infrastructure as Code", meaning that you
can declaratively define the state of your infrastructure and terraform will
perform the steps to reach that step. Think of it like the kubernetes or NixOS
configuration.

The commands for a deployment are usually the following:

```bash
terraform init
terraform plan
terraform apply
```

To undeploy:

```
terraform destroy
```
