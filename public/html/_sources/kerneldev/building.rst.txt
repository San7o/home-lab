Building Linux
==============

Some notes about building the Linux kernel.

Vanilla
-------

Build with warnings:

.. code-block:: bash

    make -j4 W=1

To build with clang:

.. code-block:: text

   make -j4 W=1 ARCH=x86_64 HOSTCC=clang CC=clang

Cross compile:

.. code-block:: text

   make -j4 ARCH=x86_64 CROSS_COMPILE=/usr/bin/x86_64-pc-linux-gnu-

Tuxmake
-------

If you just want to build the kernel and you don't want to deal with
dependencies, tuxmake is a great tool for this.

You can go yo the kernel root directory and simply run `tuxmake` to build it.
You can specify some configuration flags. Tuxmake will download a docker
container for the build and configure the toolchain and .config based on the
falgs.

.. code-block:: bash

    cd linux
    tuxmake

    # or
    tuxmake --target-arch=arm64 \
            --toolchain=gcc-10  \
            --kconfig-add /path/to/my.config

Build Configs
-------------

Some build configs you should know about:

- CONFIG_KASAN=y
  CONFIG_KASAN_GENERIC=y
  #CONFIG_KASAN_SW_TAGS=y
  #CONFIG_KASAN_HW_TAGS=y
  CONFIG_KASAN_VMALLOC=y

  Enable the generic kernel address sanitization, then pick the one you want.

- CONFIG_UBSAN=y

  Enable runtime undefined behaviour checker.

- CONFIG_LOCKDEP=y

  Catch deadlocks

- CONFIG_DEBUG_VM=y

  Do this when touching memory management or DMA.

- CONFIG_PROVE_RCU=y

  This ensures you are accessing RCU-protected memory properly

- CONFIG_SLUB_DEBUG_ON=y

  Do more checks on the slab allocator

- CONFIG_DEBUG_STACKOVERFLOW=y

  Check that we did not put huge object on the stack, because it is very
  limited.

- CONFIG_DETECT_HUNG_TASK=y

  If you accidentally put a process into an uninterruptible sleep, this will
  dump the stack trace
