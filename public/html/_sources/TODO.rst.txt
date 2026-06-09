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

  a. Follow this Yocto course:

      https://www.yoctoproject.org/wp-content/uploads/sites/32/2023/10/LinuxLAB-2018-Yocto-Koan-min.pdf

  b. Follow this Device Tree course:

      https://hosted-files.sched.co/ossindia2026/69/DTS%20101%20From%20Roots%20to%20Trees%2C%20aka%20Devicetree%20for%20Beginners%20-%20Krzysztof%20Kozlowski%2C%20Qualcomm%20-%20OSS%20India%202026.pdf

  c. boot a yocto BSP on a raspberry pi 3b
  d. boot a yocto BSP on a beaglebone balck

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

