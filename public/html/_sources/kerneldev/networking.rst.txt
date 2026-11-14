Networking
==========

Notes about Linux networking.

AF_XDP
------

XDP can be used for high-performance packet processing. To use XDP, you need an
XDP eBPF program, and, optionally, an userspace program that for processing.
Conceptually, the XDP program forwards the packet to the user via an eBPF map,
the user can . The userspace program can consume and produce packets.

You need to know about UMEM. UMEM is a region of virtual contiguous memory,
divided into equal-sized frames. An UMEM is associated to a netdev and a
specific queue id of that netdev (usually there is one queue per CPU, but it can
be configured). An AF_XDP is socket linked to a single UMEM, but one UMEM can
have multiple AF_XDP sockets (via XDP_SHARED_UMEM).

4 ring buffers are used, all rings are single-producer and single-consumer:

* FILL buffer: user writes UMEM addrs to send to the kernel

* COMPLETION buffer: the kernel sends UMEM addrs that is has processed, giving
  the ownership back to userspace. This does not necessarely mean that the
  packet was successfully sent or received. The user application consumes UMEM
  addrs from this ring.

* RX buffer: kernel writes UMEM addrs for incoming packets. The user
  application consumes `struct xdp_desc` descriptors from this ring.

* TX buffer: user writes UMEM addrs for sending the packet. The user
  application produces `struct xdp_desc` descriptors to this ring.

Additional information:

    https://www.kernel.org/doc/html/latest/networking/af_xdp.html

    http://oldvger.kernel.org/lpc_net2018_talks/lpc18_paper_af_xdp_perf-v2.pdf

    https://lwn.net/Articles/750845/

Bare UDP Tunnelling Module
--------------------------

Sometimes it is useful to encapsulate L3 protocols inside UDP. For example, UDP
ports are used for load balancing. See https://www.rfc-editor.org/info/rfc7510/

Documentation: https://www.kernel.org/doc/html/latest/networking/bareudp.html

Batman-adv
----------

Batman advanced is a new approach to wireless networking which does no longer
operate on the IP basis. Unlike the batman daemon, which exchanges information
using UDP packets and sets routing tables, batman-advanced operates on ISO/OSI
Layer 2 only and uses and routes (or better: bridges) Ethernet Frames. It
emulates a virtual network switch of all nodes participating. Therefore all
nodes appear to be link local, thus all higher operating protocols won’t be
affected by any changes within the network. You can run almost any protocol
above batman advanced, prominent examples are: IPv4, IPv6, DHCP, IPX.

Website: https://www.open-mesh.org/projects/open-mesh/wiki

SocketCAN
---------

The socketcan package is an implementation of CAN protocols (Controller Area
Network) for Linux. CAN is a networking technology which has widespread use in
automation, embedded devices, and automotive fields. While there have been other
CAN implementations for Linux based on character devices, SocketCAN uses the
Berkeley socket API, the Linux network stack and implements the CAN device
drivers as network interfaces. The CAN socket API has been designed as similar
as possible to the TCP/IP protocols to allow programmers, familiar with network
programming, to easily learn how to use CAN sockets.

Documentation: https://www.kernel.org/doc/html/latest/networking/can.html

The UCAN protocol
-----------------

TODO
