Udev rules
==========

Allow access to a device for users in the `plugdev` group:

.. code-block:: bash

    sudo nano /etc/udev/rules.d/99-logic-analyzer.rules

.. code-block:: bash

    SUBSYSTEM=="usb", ATTRS{idVendor}=="0925", ATTRS{idProduct}=="3881", GROUP="plugdev", MODE="0660"

.. code-block:: bash

   sudo udevadm control --reload-rules
   sudo udevadm trigger
