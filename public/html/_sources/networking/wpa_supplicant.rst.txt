WPA supplicant
==============

To use wpa_supplicant, you need to setup the configuration, start the daemon,
and use the wpa_cli.

Edit `/etc/wpa_supplicant/wpa_supplicant.conf`:

.. code-block:: text

   ctrl_interface=/run/wpa_supplicant
   update_config=1
   country=IT

   network={
        ssid="eduroam"
        scan_ssid=1
        key_mgmt=WPA-EAP
        eap=PEAP
        phase1="peapver0"
        phase2="auth=MSCHAPV2"
        identity="name.surname@unitn.it"
        passwprd="my_password"
        ca_cert="/etc/ssl/certs/ca-certificates.crt"
        ieee80211w=0
        domain_suffix_match="unitn.it"
   }

Edit /etc/network/interfaces

.. code-block:: text

  allow-hotplug wlan0
  iface wlan0 inet dhcp
      wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

Run the daemon:

.. code-block:: text

   wpa_supplicant -d -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant-eduroam.conf

Use wpa_cli:

.. code-block:: text

   wpa_cli
   > status
   > list_networks
   > select_network 0

This should be enough to connect to the internet. If you have a container or
virtual machine, you may have to do additional steps like:

.. code-block:: text

    iptables -t nat -A POSTROUTING -s '192.168.100.0/24' -o wlan0 -j MASQUERADE

or adding a nameserver in `/etc/resolv.conf`
