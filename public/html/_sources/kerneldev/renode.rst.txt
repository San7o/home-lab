Renode
======

Renode is "a virtual development tool for multi-node embedded networks (both
wired and wireless) and is intended to enable a scalable workflow for creating
effective, tested and secure IoT systems."

You can essentially emulate commercial architectures and boards.

Commands
--------

Print the program counter:

.. code-block:: bash

   cpu PC

Query system bus device at address:

.. code-block:: bash

   sysbus WhatIsAt <addr>

Peek a location in memory:

.. code-block:: bash

   sysbus ReadDoubleWord <addr>

Start the emulation:

.. code-block:: bash

   start
