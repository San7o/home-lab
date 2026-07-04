SWD
===

Serial Wire Debug (SWD) is a two-wire interface used for debugging and
programming ARM microcontrollers. You usually need an SWD controller, which can
be done my most microcontrollers, sucj as the raspberry pi pico 2.

Pico 2
------

To use the pico2 for SWD you can use the official `Debugprobe <https://github.com/raspberrypi/debugprobe>`_ by following the instructions in the readme:

.. code-block:: bash

   git clone --recurse-submodules https://github.com/raspberrypi/debugprobe.git
   mkdir build-pico2
   cd build-pico2

   cmake -DDEBUG_ON_PICO=1 -DPICO_BOARD=pico2 -DPICO_SDK_FETCH_FROM_GIT=on -DPICOTOOL_FORCE_FETCH_FROM_GIT=on ../
   cmake --build .


