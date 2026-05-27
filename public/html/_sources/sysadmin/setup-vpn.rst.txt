Setup a VPN
===========

In this quick note I want to document a very useful service I have been using,
tailscale_. This blog post is not sponsored, I genually benefit from their
service and I think it is awesome.

.. _tailscale: https://tailscale.com/

Tailscale is a VPN with a generous free tier which lets up to 3 concurrent users
access 100 devices on their VPN. Differently from other free VPNs, they give you
a lot of freedom, for example you can open any port and host your services. This
is awesome if you just need to connect to your computer / server remotely and
you do not have control on port-forwarding in the router (which is my
situation).

A good alternative is netbird_, the installation is very similar to tailscale,
and the server part of netbird is open source.

.. _netbird: https://netbird.io/

Installing tailscale
--------------------

Installing tailscale is quite straight forward, there are instructions
on their website for each linux distribution. For debian, the
installation looks like this:

- Add Tailscale's package signing key and repository:

.. code-block:: bash

    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

- Install Tailscale:

.. code-block:: bash

    sudo apt-get update
    sudo apt-get install tailscale

- Connect your machine to your Tailscale network and authenticate in your browser:

.. code-block:: bash

    sudo tailscale up

- You can find your Tailscale IPv4 address by running:

.. code-block:: bash

    tailscale ip -4

Once you installed the application and logged in the platform, you have a
dashboard with all your connected machines. Pretty amazing.

I have been using this service all the time to connect to my machines, and I can
easily recommend it.

