#!/bin/sh

IMG_NAME="Image.img"
SIZE=20G

if [ $# -ge 1 ]; then
    IMG_NAME="$1"
fi
if [ $# -ge 2 ]; then
    SIZE="$2"
fi

echo "Creating image $IMG_NAME with size $SIZE"
qemu-img create -f qcow2 $IMG_NAME $SIZE
