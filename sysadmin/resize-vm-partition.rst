Resize VM Partition
===================

So you just changed the disk size of a virtual machine on proxmox, but you don't
see the updated size inside the VM when you run `lsblk` or `df -h`.

First, rescan your disk:

.. code-block:: bash

   echo 1 | sudo tee /sys/class/block/sda/device/rescan

This is your situation:

.. code-block:: bash

   $ lsblk -a
   NAME                MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
   sda                   8:0    0   248G  0 disk 
   ├─sda1                8:1    0     2M  0 part 
   ├─sda2                8:2    0   500M  0 part /boot/efi
   ├─sda3                8:3    0     2G  0 part /boot
   └─sda4                8:4    0 245.6G  0 part            # HERE!!!
     └─systemVG-LVRoot 252:0    0 117.6G  0 lvm  /
   ...
   
   $ df -h
   Filesystem                   Size  Used Avail Use% Mounted on
   /dev/mapper/systemVG-LVRoot  118G   13G  106G  11% /
   ...

To expand `sda4` to the full size, run this:

.. code-block:: bash

   sudo pvresize /dev/sda4
   sudo lvextend -r -l +100%FREE /dev/systemVG/LVRoot
