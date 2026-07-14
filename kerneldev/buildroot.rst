Buildroot
=========

Buildroot is quite straight forward to use.

.. code-block:: bash

    # See which configs are available
    ls configs/ | grep qemu

    make menuconfig
    make linux-menuconfig
    make <config>

