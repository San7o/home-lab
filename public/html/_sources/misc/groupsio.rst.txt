Groups.io Mailing Lists
=======================

Some projects use Groups.io to manage their mailing lists, such as new projects
from the Linux Foundation like `ELISA <https://lists.elisa.tech/g/main>`_ and
`ZephyrOS <https://lists.zephyrproject.org/g/main/subgroups>`_. If you don't
want to subscribe to them with your email, and keep your workflow using good old
mailboxes and lei, you need to do a bit of setup. I will use `rss2email` for
this.

.. code-block:: bash

    mkdir -p ~/Mail/elisa-archive/{cur,new,tmp}
    r2e new dummy@localhost

Add the following to `.config/rss2email.cfg`:

.. code-block:: text

    [DEFAULT]
    date-header = True
    email-protocol = maildir
    imap-mailbox = INBOX
    maildir-path = /home/user/Mail/elisa-archive
    maildir-mailbox = 

Setup mailbox:

.. code-block:: bash

    r2e add elisa-devel https://lists.elisa.tech/g/devel/rss
    r2e run
    lei import maildir:$HOME/Mail/elisa-archive

Now you can use any mail reader on `~Mail/elisa-archive`, like `neomutt`.

You can add multiple feeds in the same mailbox, for example:

.. code-block:: bash

   r2e add elisa-safety https://lists.elisa.tech/g/safety-architecture/rss
   r2e add elisa-automotive https://lists.elisa.tech/g/automotive/rss
   r2e add elisa-aerospace https://lists.elisa.tech/g/aerospace/rss
   r2e run

If you want to remove a feed, do this instead of modifying the config file:

.. code-block:: bash

   r2e deletel elisa-devel

This is needed because `rss2email` keeps a database of the feeds, and it needs
to be updated to register your change.
