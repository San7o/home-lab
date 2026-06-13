EDK II
======

EDK II is the reference implementation of UEFI, it is the most popular UEFI
firmware used in the real world. The project is open source but it is directed
maily by Intel and other big corporations such as Microsoft and AMD.

OVMF is the version of EDK II bootable by Qemu, it can be built from the EDKII
repository.

Building
--------

Clone the repo:

.. code-block:: bash

    git clone --recursive https://github.com/tianocore/edk2.git
    cd edk2

Make sure you cloned with the `--recursive` flag. Or run `git submodule update
--init` otherwise.

Build:

.. code-block:: bash

    make -C BaseTools
    mkdir -p Conf
    . edksetup.sh
    
    cat << EOF > Conf/target.txt
    ACTIVE_PLATFORM       = OvmfPkg/OvmfPkgX64.dsc
    TARGET                = RELEASE
    TARGET_ARCH           = X64
    TOOL_CHAIN_TAG        = GCC
    BUILD_RULE_CONF       = Conf/build_rule.txt
    EOF
    
    build -D SECURE_BOOT_ENABLE=FALSE \
          -D NO_SHELL=FALSE

We need to disable secure boot if we want to enable the shell.

You can also pass the configuration directly to the `build` command:

.. code-block:: bash

   build -p OvmfPkg/OvmfPkgX64.dsc \
      -a X64 \
      -b RELEASE \
      -t GCC \
      -D NO_SHELL=FALSE \
      -D SECURE_BOOT_ENABLE=FALSE

Binaries are generated in `Build/Ovmfx64/RELEASE_GCC5/FV`.

To boot an image, for example Fedora, with qemu:

.. code-block:: bash

    qemu-system-x86_64 \
        -enable-kvm \
        -m 2G \
        -smp 2 \
        -cpu host \
        -drive if=pflash,format=raw,readonly=on,file=Build/OvmfX64/RELEASE_GCC/FV/OVMF_CODE.fd \
        -drive if=pflash,format=raw,file=Build/OvmfX64/RELEASE_GCC/FV/OVMF_VARS.fd \
        -cdrom ~/Downloads/Fedora-i3-Live-44-1.7.x86_64.iso \
        -netdev user,id=n1 \
        -device virtio-net-pci,netdev=n1 \
        -vga std
