# Ansible

Ansible lets you run tasks on multiple machines. It does not require
the machines to have any particular software installed other then ssh,
only the control node needs to have ansible installed.

You delcare your nodes in an inventory file (in this case
`inventory.ini` or `inventory.yaml`). You define your tasks in a
playbook (for example `playbooks/test.yaml`).

Some actions require sudo (`become: true`), so you may need to setup a
privileged user that is not prompted a password when using sudo
(modify the `/etc/sudoers` file).

You should be able to install ansible via your packet manager.

To run a playbook:

```bash
ansible-playbook -i inventory.ini -u lab playbooks/test.yaml
```

To run a specific task, specify a tag:

```bash
ansible-playbook -i inventory.ini -u lab playbooks/test.yaml --tags ping
```
