Setup a Minecraft Server
========================

In this page I want to quickly explain how to setup a minecraft server. You can
follow this document regardless of your platform since you only need the java
virtual machine to run the server.

Vanilla server
--------------

Setting up a vanilla server is very simple, just download the jar file from the
Mojang_ website and move it on Its own directory (it will generate a bunch of
garbage) and run it using the JVM:

.. _Mojang: https://www.minecraft.net/en-us/download/server

.. code-block:: bash

   java -Xmx1024M -Xms1024M -jar server.jar nogui

You can set many flags to fine tune various aspects of the server such as how
much resources does it use and multi threading. You can find some information
here_.

.. _here: https://docs.papermc.io/paper/aikars-flags/

The first time you run the server, it will fail with error "Failed to load
eula.txt". You are required to accept the eula_ agreement. If you want to
proceed, you should edit a file named "eula.txt" in the same directory as the
.jar file and set the "eula" value to true.

.. _eula: https://www.minecraft.net/en-us/eula

.. code-block:: text

   eula=true

Then run the server again and you should see a message saying "Starting
Minecraft server on `*:25565`" and the world being generated. Congratulations,
you have your vanilla minecraft server. You can connect to the server via the IP
of the machine in the network.

Note that if you have a firewall, you need to check that the port is accessible
from other machines. If you need the server to be reachable from other networks,
you need to configure port forwarding on your router or use a VPN.

PaperMC
-------

PaperMC_ is a popular server that enables the use of plugins. The experience is
very similar to the vanilla server but you also get to configure all the
plugins.

.. _PaperMC: https://docs.papermc.io/

You can download paper from the official website and run it with the JVM:

.. code-block:: bash

    java -Xmx1024M -Xms1024M -jar paper-1.21.4-231.jar nogui

As always, you will need to edit the eula file that will be generated after the
first run.

You can browse and download plugins in the Hangar_ website, then move them in
the "plugin" directory in your server's directory.

.. _Hangar: https://hangar.papermc.io/
