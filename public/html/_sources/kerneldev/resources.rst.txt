Kernel Dev Resources
====================

Important
---------

- archive of all mails from the mailing lists:
  
    https://lore.kernel.org/

- git trees:

    https://git.kernel.org/

- patchwork

    https://patchwork.kernel.org/

Secondary but important
-----------------------

- syzkaller fuzzer:

    https://syzkaller.appspot.com/upstream

- bugzilla:

    https://bugzilla.kernel.org/

Good documentation
------------------

- Elixir Cross References

    https://elixir.bootlin.com/linux/v7.0.9/source

- `Documentation/` directory

- Kernel Internals

    https://kernel-internals.org/

Others
------

- sashiko, AI patch reviews:

    https://sashiko.dev/

- KernelCI, distributed Linux build testing infrastructure:

    https://dashboard.kernelci.org/tree

Notable patches
---------------

Antonio Quartulli's final OpenVPN data channel offload patch:

   [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel Offload
   https://lore.kernel.org/netdev/20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net/

Andrea Porta's initial support for the BCM2712 SoC (rpi5):

   [PATCH v2 0/4] Add minimal boot support for Raspberry Pi 5
   https://lore.kernel.org/lkml/cover.1715332922.git.andrea.porta@suse.com/

Stefano Radaelli supports a new board:

   [PATCH v2 0/3] Add support for Variscite DART-MX93 and Sonata board
   https://lore.kernel.org/lkml/cover.1774601806.git.stefano.r@variscite.com/

Fixing a format specifier error:

   [PATCH] HID: core: Fix size_t specifier in hid_report_raw_event()
   https://lore.kernel.org/linux-input/20260517-hid-core-fix-size_t-specifier-v1-1-bfdd959ec383@kernel.org/T/#u
