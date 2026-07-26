Linux Architecture Diagrams
===========================

Networking Stack
----------------

.. image:: ../images/linux-networking-stack.png

Concepts:

* NAPI_ (New API): poll packets from the NIC in bulk so that it does not
  interrupt the CPU too much

* Netlink_: we use this to communicate with the kernel and configure the network
  stack

* `TUN`: L3 virtual tunnel

* `TAP`: L2 virtual tap

* `veth`: virtual Ethernet devices. veth devices are always created in
  interconnected pairs so that packets  transmitted on one device in the pair
  are immediately received on the other device. A  particularly  interesting use
  case is to place one end of a veth pair in one network namespace and the other
  end in another network namespace, thus allowing communi‐ cation between
  network namespaces. See `veth(4)`.

Future developments:

- `netkit`_: eBPF-programmable network device

.. _NAPI: https://docs.kernel.org/networking/napi.html
.. _Netlink: https://www.kernel.org/doc/html/next/userspace-api/netlink/intro.html)
.. _netkit: https://lwn.net/Articles/949960/

Storage Stack
-------------

.. image:: ../images/linux-storage-stack.png

To manage read and writes to the storage device, the Linux kernel uses the `bio`
structure which connects the filesystem to a particular storage device.

In order to not issue many commands to the storage device, the `bio` manages a
page cache. This is a copy-on-write cache which gets checked before accessing a
page. If data gets written to a page, the cache gets dirty, and it can be
flushed to the device.

- `Storage Performance Development Kit`_: fast and modern API to interact with
  NVMe devices

.. _Storage Performance Development Kit: https://spdk.io/)

Rendering Stack
---------------

TODO: I still need to do a deep down here. Here is my understanding after
working with graphics in userspace.

.. image:: ../images/linux-rendering-stack.png

Unique Kernel Contributors per Subsystem
----------------------------------------

+-----------------------+---------------+-------------------------------------+
| Subsystem             | Percentage    | Info                                |
+=======================+===============+=====================================+
| Drivers (General)     | ~55% - 60%    | This includes GPU (about 30% of all |
|                       |               | drivers), Network, Multimedia, and  |
|                       |               | Sound.                              |
+-----------------------+---------------+-------------------------------------+
| Networking (net/)     | 8% - 10%      | Massive corporate focus from Meta,  |
|                       |               | Google, and Mellanox/Nvidia. This   |
|                       |               | is the core of the cloud.           |
+-----------------------+---------------+-------------------------------------+
| Filesystems (fs/)     | ~7% - 8%      | This is the "Data Integrity" tier.  |
|                       |               | Recent spikes come from Bcachefs    |
|                       |               | (Kent Overstreet) and cloud-scale   |
|                       |               | optimizations for NVMe.             |
+-----------------------+---------------+-------------------------------------+
| Core Kernel (kernel/, | ~5%           | The "Priesthood." This is the       |
| mm/)                  |               | smallest group of developers, but   |
|                       |               | they have the highest gatekeeping   |
|                       |               | standards. It includes scheduling   |
|                       |               | and memory management.              |
+-----------------------+---------------+-------------------------------------+
| eBPF (kernel/bpf)     | ~4%           | This is the fastest-growing niche.  |
|                       |               | eBPF is becoming the universal      |
|                       |               | "glue" for observability and        |
|                       |               | networking, drawing in engineers    |
|                       |               | from Distributed Systems.           |
+-----------------------+---------------+-------------------------------------+
| Arch Specific (arch/) | ~10%          | Mostly ARM64 and RISC-V churn.      |
|                       |               | RISC-V is currently seeing a "gold  |
|                       |               | rush" of first-time contributors.   |
+-----------------------+---------------+-------------------------------------+

Source: gemini.
