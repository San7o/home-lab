WARP
====

Cloudflare WARP is a service that routes your traffic through Cloudflare's
network. It uses WireGuard to create a secure tunnel for your data.

This is useful when certain domains are blocked by your internet service
provider, such as on your campus network.

On Debian, install, enable and connect to the service by following these
instructions:

.. code-block:: bash
   
   curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-warp.list
   sudo apt update
   sudo apt install cloudflare-warp
   sudo systemctl enable --now warp-svc
   warp-cli registration new
   warp-cli mode warp
   warp-cli connect

To check that WARP is successfully routing the traffic, run:

.. code-block:: bash
  
   curl https://www.cloudflare.com/cdn-cgi/trace

Useful commands:

.. code-block:: bash

   warp-cli disconnect
   warp-cli status
