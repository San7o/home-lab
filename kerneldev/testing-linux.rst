Testing Linux
=============

There are many ways to test the Linux kernel.

Official documentation:

    https://docs.kernel.org/dev-tools/testing-overview.html

KUnit
-----

KUnit is a framework to run unit tests inside the kernel. They can access
internal functions in the kernel, and it is relatively straight forward.

This command will configure, build and run a Linux kernel with KUnit tests:

.. code-block:: bash

   ./tools/testing/kunit/kunit.py run

kselftest
---------

Userspace tests.

.. code-block:: bash

   make headers
   make -C tools/testing/selftests
   make -C tools/testing/selftests run_tests
   make kselftest

KernelCI
--------

A distributed test automation system, where many systems run by companies or
volunteers run tests automatically and periodically.

    https://kernelci.org/

If you want to run tests locally without sending data to KernelCI, you need to
configure LAVA:

    https://gitlab.com/lava/lava
