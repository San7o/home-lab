Setup an IRC client
===================

In this note I will explain how to setup your client to connect to an IRC server
just in case I need to do it again, nothing difficult or impressive really.

Bouncer
-------

You want to have a bouncer running on your network, this is needed because when
you close any IRC client you will loose all the messages. What a bouncer does is
connecting to any IRC server for you, then you will connect to the bouncer
instead of connecting directly to the IRC server. As long as the bouncer is live
somewhere in your network, you won't loose messages and you can connect via
different client and devices to the same bouncer.

You can use ZNC_ as a bouncer, it is already packaged in many distributions. On
fedora, it is as easy as running:

.. _ZNC: https://wiki.znc.in/ZNC

.. code-block:: bash

    sudo dnf install znc

Fedora will also setup the systemd daemon that you can enable if you want. In
order to setup the bouncer, run:

.. code-block:: bash

    znc --makeconf

This will prompt you a few settings. I will configure so that it will connect to
libera and disable ssl because it gave me problems.

.. code-block:: text

    $ znc --makeconf
    
    [ .. ] Checking for list of available modules...
    [ ** ]
    [ ** ] -- Global settings --
    [ ** ]
    [ ?? ] Listen on port (1025 to 65534): 1025
    [ ?? ] Listen using SSL (yes/no) [no]: no
    [ ?? ] Listen using both IPv4 and IPv6 (yes/no) [yes]: no
    [ .. ] Verifying the listener...
    [ ** ] Unable to locate pem file: [/home/santo/.znc/znc.pem], creating it
    [ .. ] Writing Pem file [/home/santo/.znc/znc.pem]...
    [ ** ] Enabled global modules [webadmin]
    [ ** ]
    [ ** ] -- Admin user settings --
    [ ** ]
    [ ?? ] Username (alphanumeric): santo_
    [ ?? ] Enter password:
    [ ?? ] Confirm password:
    [ ?? ] Nick [santo_]:
    [ ?? ] Alternate nick [santo__]:
    [ ?? ] Ident [santo_]:
    [ ?? ] Real name (optional):
    [ ?? ] Bind host (optional):
    [ ** ] Enabled user modules [chansaver, controlpanel]
    [ ** ]
    [ ?? ] Set up a network? (yes/no) [yes]: yes
    [ ** ]
    [ ** ] -- Network settings --
    [ ** ]
    [ ?? ] Name [libera]: libera
    [ ?? ] Server host (host only): irc.libera.chat
    [ ?? ] Server uses SSL? (yes/no) [no]: no
    [ ?? ] Server port (1 to 65535) [6697]:
    [ ?? ] Server password (probably empty):
    [ ?? ] Initial channels: #linux
    [ ** ] Enabled network modules [simple_away]
    [ ** ]
    [ .. ] Writing config [/home/santo/.znc/configs/znc.conf]...
    [ ** ]
    [ ** ] To connect to this ZNC you need to connect to it as your IRC server
    [ ** ] using the port that you supplied.  You have to supply your login info
    [ ** ] as the IRC server password like this: user/network:pass.
    [ ** ]
    [ ** ] Try something like this in your IRC client...
    [ ** ] /server <znc_server_ip> +1025 santo_:<pass>
    [ ** ]
    [ ** ] To manage settings, users and networks, point your web browser to
    [ ** ] https://<znc_server_ip>:1025/
    [ ** ]
    [ ?? ] Launch ZNC now? (yes/no) [yes]: no

You can finally run ZNC by running the command `znc`, `znc --debug` or via the
systemd daemon. Check that you do not have firewall rules that may block binds
to the port.

Additionally, you can accesses an admin panel via http, as the output of
makeconf suggested.

    https://<znc_server_ip>:1025/

Clients
-------

There are as many IRC clients as you want. Now I use weechat_ which is tui
based, it is probably already packaged by your distribution.

.. _weechat: https://weechat.org/

.. code-block:: bash

    sudo dnf install weechat

Once you run weechat, you can connect to your server by first adding a server
and connecting to it:

.. code-block:: bash

    /server add local localhost/1025
    /connect local -username=santo_ -password=my-password

You should see a buffer opening with a welcome message. If this is not the case,
something went wrong. If you get the message "this nickname is registered.
Please choose a different nickanme" you either are already registered with that
nickname and you should login with `/mng NickServ IDENTIFY username password`,
or someone already registered that nickname and you need to change it. In this
case, you can directly edit the ZNC config file in `~/.znc/configs/znc.conf` and
restart the server with a different nickname.

To join a channel use the =join= command:

.. code-block:: bash

    /join #<channel-name>

A useful command in weechat is to enable mouse support:

.. code-block:: bash

    /mouse enable

