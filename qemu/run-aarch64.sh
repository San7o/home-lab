#!/bin/sh

# A good ARM distribution is alpine linux

IMG=alpine-virt-3.23.4-aarch64.iso
DISK=alpine_disk.qcow2

qemu-system-aarch64 \
    -cpu cortex-a53 \
    -smp cores=4  \
    -M virt \
    -m 4096 \
    -bios edk2-aarch64-code.fd \
    -drive format=qcow2,file=$DISK \
    -device ramfb \
    -cdrom $IMG \
    -nic user,model=virtio \
    -rtc base=utc,clock=host \
    -nographic
