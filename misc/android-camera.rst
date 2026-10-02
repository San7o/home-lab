Android camera
==============

This short guide will explain how to access both front and back cameras of an
android device from Linux via USB. This will give you a good video stream with
very little delay.

First, you need to enable USB debugging on the android device. To do this,
enable the developer mode by tapping multiple times on the android build number
in the settings. This will make a new panel appear in the settings where you can
enable USB debugging. Finally, connect the android device to your Linux machine
via USB and allow all permissions when prompted. Let's now move to Linux.

First, install the necessary dependencies. On Debian they are these:

.. code-block:: bash

    sudo apt update
    sudo apt install v4l2loopback-dkms ffmpeg

You may need to install Linux headers:

.. code-block:: bash

   sudo apt install linux-headers-amd64

Load the module to create the virtual webcam:

.. code-block:: bash

    sudo modprobe v4l2loopback exclusive_caps=1 card_label="Android Camera" video_nr=2

Download and run scrcpy, following the `documentation
<https://scrcpyapp.org/en/guides/linux/>`_, then unpack it and run:

.. code-block:: bash

    ./scrcpy --video-source=camera --camera-size=1920x1080 --v4l2-sink=/dev/video2 --no-audio

Where `/dev/video2` is the device corresponding to the android device, which
corresponds to the `video_nr` parameter passed to the kernel module. And there
we go. You can add `--camera-facing=front` if you want to get the front camera.
The new camera should be available on Discord and other applications.

Troubleshooting
---------------

It may happen that after unplugging and plugging the android device, `adb` does
not authorize the connection anymore. To solve this, first try to restart adb:

.. code-block:: bash

   adb kill-server
   adb start-server

If that did not work, go to you device and disable USB debug and remove all old
authorizations for them. Then enable it again and connect the device to your
Linux machine and see if it prompts you for permissions.
