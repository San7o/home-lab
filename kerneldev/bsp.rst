Board Support Package
=====================

A Board Support Package (BSP) is a collection of software that enables the
operating system to interact with the hardware. People who manage BSP are
essentially plumbers, they connect these software for a particular use case
of a customer.

This includes:

- the firmware: this is mostly closed source and embedded in the SoC (Boot ROM)
  or loaded (/lib/firmware), but you rarely need to write it
- the bootloader: usually U-boot, it boots the operating system
- the kernel: your fork of the linux kernel
- the device tree: this is custom makde for a specific application and lives
  inside the linux fork, it describes the hardware that is enabled in this BSP
- the machine image: root filesystem and the rest of the image

Yocto is used to build the entire BSP. Developers may also need to extend the
bootloader, or even write a driver (not the majority of cases, and it is
usually not upstreamed).

Who makes the package may also need to maintain the kernel since the
manufacturers would never be so kind.
