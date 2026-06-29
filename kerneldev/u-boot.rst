U-boot
======

Git reference:

    https://source.denx.de/u-boot/u-boot.git

Patchwork:

    https://patchwork.ozlabs.org/project/uboot/list/

Mailig list:

    u-boot@lists.denx.de

Lore archive:

    https://lore.kernel.org/u-boot/

The U-boot development structure is very similar to Linux's, so you will feel at
home if you are already familiar with working on Linux.

Quickstart
----------

See which boards are supported:

.. code-block:: bash

   cd u-boot
   ls configs

Choose a config:

.. code-block:: bash

   make qemu_arm64_defconfig

You can also use the good old `menuconfig`:

.. code-block:: bash

   make menuconfig

Build:

.. code-block:: bash

   CROSS_COMPILE=aarch64-linux-gnu- make -j4

If you built a quemu config, the simplest way you can boot it is via the
following command:

.. code-block:: bash

   qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 -bios u-boot.bin

Architecture
------------

In order to boot many operating systems on many architectures, we need to setup
some abstractions.

- bootdev: storage device that can provide an operating system
- bootflow: an OS to boot
- bootmeth: methods for finding bootflows on bootdevs

Additionally, uboot can provide an EFI layer, with secure boot support.

A very cool layer is the Verified Boot for Embedded (VBE). This is a true UEFI
alternative, where the key idea is that the operating system tells the
bootloader what it needs and how it should be booted, so the bootloader can be
configured at runtime.

The "expo" subsystem supports graphical / text display.

"binman" is used to create the image.

Booting
-------

This is what happens when you turn on the board:

- The CPU starts with low-power. A SoC specific ROM code gets executed.

  - `lowlevel_init` is called, which sets up things such as RTC and CAR. Code
    lives in `board/BOARD/lowlevel.S`.

  - It may then jump to `s_init`. If SPL is not used, then this does what the
    SPL would do like setting up muxing, clocks, DRAM, clear BSS, start a
    console.

- Teriary Program Loader (TPL, optional): very early init, as tiny as possible.
  It loads the SPL or VPL if enabled. Some SoCs like Rockchip do DRAM
  initialization here.

- Verifying Program loader (VPL, optional): the first stage of the boot loader. It loads
  the next stage and ensures that no one has tampered with the firmware.

- Secondary Program Loader (SPL, optional): miniature bootloader that lives
  entirely within the SoC's internal SRAM. Its primary job is to initialize the
  DDR memory controller so that the main bootloader can be loaded.

  * `board_init_f` is called before U-boot is loaded. Code lives in
    `arch/ARCH/march-SOC/spl.c`.

    * Does the whole DRAM initialization, clear BSS and other necessary stuff.

    * Usually calls things like `board_early_init_f`, `spl_early_init_f` and all
      the other inits.

  * `relocate_code` moves U-boot to final location
  * `board_init_r` called in post relocation

- Trusted Firmware-A (TF-A, ARM) + Open Protable Trusted Execution Environment
  (OP-TEE): A secure software layer that processes sensitive security oprations

- U-Boot: loads the operating system

- OS: the end (and the start of everything else)

Devices are initialized in a staged approach: SPL handles essential hardware
(clocks, pinmux, DRAM, watchdog), U-Boot Proper initializes most peripherals
(MMC, network, storage) via the Driver Model, and the OS handles devices that
U-Boot doesn't use. The Driver Model uses lazy probing, meaning that devices are
only initialized when actually accessed.

Testing U-boot
--------------

There are some secrets you need to know in order to run tests in u-boot, there
is no documentation about this.

Create a python environment and install the dependencies from some files:

.. code-block:: bash

    # (optional quest) Find a way to install libgit2 v1.7... not even debian is this old

    python3 -m venv .venv
    source .venv/bin/activate
    
    REQS=$(find . -name requirements.txt); for REQ in $REQS; do pip3 install -r $REQ; done;

Run the tests:

.. code-block:: bash

    make check

Videos
------

Recent Advances in U-Boot - Simon Glass, Google Inc.

    https://www.youtube.com/watch?v=YlJBsVZJkDI
