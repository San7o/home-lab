Kernel Routine
==============

I do this everyday to stay up to date with kernel changes and learn new things.

Morning routine
---------------

Read latest RSS feeds (phoronix, LWN, lots of blogs from kernel devs, securtiy
mailing lists and news...). I use gnus on emacs for this.

Read latest patches of the subsystems I follow, I use `lei` and `neomutt`

.. code-block:: bash

    ./scripts/lei-update.sh
    neomutt -f ~/Mail/<mailbox>/

Apply patches from the mailing list. For a multi patch series, grab the
Message-Id of the cover letter.

.. code-block:: bash

    b4 am <Message-Id>
    # Follow output instructions
    # Check out the commits
    git log -n 5

Build the kernel:

.. code-block:: bash

    # Build just the driver first
    make -j4 M=<location-of-my-module>
    # Then build the kernel
    make -j4

then test the patch with whatever tesing setup I am using.

Update my current working tree:

.. code-block:: bash

    # First time setup

    # Clone mainline tree from git.kernel.org:
    git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git kernel-mainline
    # Add the origins you follow
    # git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
    # git remote add netdev https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
    # git remote add bpf-next https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
    # git remote add bpf https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
    git remote add staging git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git

    cd linux
    git fetch --all --jobs=4
    # or just fetch what you need:
    # git fetch origin && git fetch netdev && git fetch bpf

When you are working on your branch of a tree, like staging, always fetch the
closest tree and linux-next, then base or rebase your new development branch on
-next:

.. code-block:: bash

    get fetch linux-next
    git fetch staging
    # When creating a new branch
    git checkout -b my-staging-feature staging/staging-next

Always rebase before sending a patch:

.. code-block:: bash

    git rebase staging/staging-next

NOTE: If you rebase when submitting a new patch version, you have to state it
under --- or the maintainer will get very upset with you.

Keep in mind how the development process works, for example for staging:

- A patch is accepted by Greg and lands in staging/staging-testing
- After passing basic build bots, Greg moves it to staging/staging-next
- Every night, the linux-next maintainer pulls staging/staging-next into the
  massive linux-next integration tree

Also git blame and git log are very useful to understand what is happening.

.. code-block:: bash

    git log bpf-next/master -n 10
    git blame -L 40,60 <file>
    git log <commit-hash>

Useful command:

.. code-block:: bash

    shh grep -rnE 'pr_err\(\s*"([^"\\]|\\.)*([^n]|[^\\].)"' .

Night routine
-------------

Work on the project I am currently working on (a driver, my OS, learning a tool
like yocto, write a compiler.... whatever).
