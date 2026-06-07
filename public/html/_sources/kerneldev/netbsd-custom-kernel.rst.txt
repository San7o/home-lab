Build a custom NetBSD Kernel
============================

Obtaining the sources
---------------------

.. code-block:: bash

    doas mkdir /usr/src
    doas mkdir /usr/xsrc
    doas chown santo /usr/src
    doas chown santo /usr/xsrc

    # Download from a release
    ftp -i ftp://ftp.NetBSD.org/pub/NetBSD/NetBSD-10.1/source/sets/
    ftp> mget *.tgz
    ftp> quit

    for file in *.tgz do
      tar -xzf $file -C /
    done

Create the kernel configuration file
------------------------------------

.. code-block:: bash

    cd /usr/src/sys/arch/amd64/conf
    cp GENERIC MYKERNEL
    config MYKERNEL

Building the kernel
-------------------

.. code-block:: bash

    cd /usr/src
    doas mkdir ../obj
    doas mkdir ../tools
    doas chown santo ../obj
    doas chwon santo ../tools
    ./build.sh -O ../obj -T ../tools -U -V HOST_CFLAGS="-Wno-error=implicit-function-declaration" tools
    ./build.sh -O ../obj -T ../tools -U kernel=MYKERNEL

Installing the new kernel
-------------------------

.. code-block:: bash

    doas mv /netbsd /netbsd.old
    doas mv ../obj/sys/arch/amd64/compile/MYKERNEL/netbsd /
    doas shutdown -r now
