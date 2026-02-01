# qemu

```
make init
make plan
make apply
```

Check that the VM is created.

```
virsh -c qemu:///system list --all
```

Start the VM:

```
virsh -c qemu:///system start lab-server-01
```
