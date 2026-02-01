#!/bin/sh

RAM=4G
IMAGE=Fedora-Server-Guest-Generic-43-1.6.x86_64.qcow2

qemu-system-x86_64 \
    --enable-kvm \
    -m $RAM \
    -drive file=$IMAGE \
    -cpu host \
    -vga virtio \
    -display sdl,gl=on
