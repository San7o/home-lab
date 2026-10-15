Possible Improvements
=====================

* Can the implementation of the algorithm for kallsyms be further improved after
  Lorenzo's patches

* Why the lsm inode cache uses so much more objects than the ext4 cache? Does
  the increased size reflect in increased performance? Why the ext4 object size
  is so huge?

.. code-block:: bash

    $ sudo cat /proc/slabinfo | grep inode
    ext4_inode_cache  147068 148596   1168   28    8 : tunables    0    0    0 : slabdata   5307   5307      0
    lsm_inode_cache   164678 197064     88   46    1 : tunables    0    0    0 : slabdata   4284   4284      0

