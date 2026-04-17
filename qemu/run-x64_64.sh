#!/bin/sh

RAM=4G
# Fedora
IMAGE=Fedora-KDE-Desktop-Live-43-1.6.x86_64.iso

# Note that to use kvm you either need sudo, or your user needs to be in
# the `kvm` group:
#     usermod -a -G kvm <username>

qemu-system-x86_64 \
    -enable-kvm \
    -m $RAM \
    -cpu host \
    -smp 3 \
    -drive file=$IMAGE \
    -vga virtio \
    -nic user,model=virtio \
    -display sdl,gl=on
