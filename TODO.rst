TODO
====

Server
------

1. document security response workflow (sources, actions, automation...)
2. try out Trivy
3. investigate periodic backup
4. investigave Restic for backup
5. make cgit work

Kernel dev
----------

1. understand the yocto+devtool+kas workflow

  a. Follow this course:

      https://www.yoctoproject.org/wp-content/uploads/sites/32/2023/10/LinuxLAB-2018-Yocto-Koan-min.pdf

  b. boot a yocto BSP on a raspberry pi 3b
  c. boot a yocto BSP on a beaglebone balck

2. work on tmp105 driver

3. complete edu-driver

Embedded
--------

1. Convert the raspberry pi pico 2 into a logic analyzer with `sigrok-pico` or
   equivalent

2. Start the new bootloader project

  a. Boot a custom EFI application
  b. Boot a bare-metal program on the BeagleBone Black
  c. make something custom boot with U-boot

