Connect LCX container to internet on proxmox
============================================

By default, LCX containers cannot access the host's network resources. This file
contains information to enable this.

Setup
-----

This is our current setup. The server host has a vmbt0 interface with an ip, say
192.169.100.2/24. The server is also connected to the internet via another
interface (ethernet, USB thetering...) with a valid ip and routes (may need to
run dhcpcd and remove the old default route `ip route del default`). The host
can do `ping kernel.org`.

Creating the container
----------------------

When creating the container, set the following options in the network setup:

- TODO: check options

Run the following command on the host:

.. code-block:: bash

   iptables -t nat -A POSTROUTING -o en+ -j MASQUERADE

Enable ip forwording, do this for both the host and the container:

.. code-block:: bash

   sysctl -w net.ipv4.ip_forward=1
   echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

Add these to host's `/etc/pve/lxc/ID.conf` to setup networking on the container:

.. code-block:: bash

    lxc.cgroup2.devices.allow: c 10:200 rwm
    lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file

Run on the container:

.. code-block:: bash

    iptables -t nat -A POSTROUTING -o nic0 -j MASQUERADE

Run tailscale on the container:

.. code-block:: bash

    tailscale up --accept-routes --advertise-routes=192.168.100.0/24

On the tailscale control panel, enable this subnet. Then on the client:

.. code-block:: bash

    sudo tailscale up --accept-routes

VM internet
-----------

If you have a VM which uses NetworkManager and you need to connect it to the
internet without a dhcpd, run this:

.. code-block:: bash

    # Read the interface name
    nmcli connection show

    # Set the IP, Gateway, and DNS (Replace 'eth0' with your connection name)
    sudo nmcli con mod eth0 ipv4.addresses 192.168.100.50/24
    sudo nmcli con mod eth0 ipv4.gateway 192.168.100.2
    sudo nmcli con mod eth0 ipv4.dns "8.8.8.8,1.1.1.1"
    sudo nmcli con mod eth0 ipv4.method manual

    # Apply the changes
    sudo nmcli con up eth0
