CCNA
====

My notes while studying for the CCNA.

To access the digital version of the book (you must have paid it):

    https://www.ciscopress.com/

Chap. 1: Introduction to TCP/IP networking
------------------------------------------

Chapter 1 introduces the basics of the TCP/IP networking model with the ISO/OSI
nomenclature (link, network, transport, application), the concept of
encapsulation and layer interactions (same-layer, adjacent-layer), and the names
of the data units (frame, packet, segment).

Chap 2: Fundamentals of Ethernet LANs
-------------------------------------

Most enterprise computer networks can be separated into two general types of
technology: local-area networks (LANs) and wide-area networks (WANs). Together
they create a complete enterprise computer network. Today's networks usually use
two general types o LANs: Ethernet LANs (aka wired LANs because of the use of
cables) and Wireless LANs.

The term Ethernet refers to an entire family of standards from the IEEE and
include the number 802.3 as the beginning part of the standard name. The
physical material used inside the cable is either copper wires  in unshielded
twisted-pair (UTP) cabling or glass fibers.

Standards
+++++++++

The standards are:

* 802.3 aka 10BASE-T aka Ethernet: 10Mbps, Copper, max 100m

* 802.3u aka 100BASE-T aka Fast Ethernet: 100Mbps, Copper, max 100m

* 802.3z aka 1000BASE-LX aka Gigabit Ethernet: 1000Mbps, Fiber, max 5000m

* 802.3ab aka 1000BASE-T aka Gigabit Ethernet: 1000Mbps, Copper, 100m

* 802.3an aka 10GBASE-T aka 10 Gig Ethernet: 10Gbps, Copper, 100m

The standards are always evolving, see `https://ethernetalliance.org/` for more
info.

Although Ethernet includes many physical layer standards, Ethernet acts like a
single LAN technology sending an Ethernet frame from source to destination
Ethernet node.

Wires
+++++

We use a pairs of wires because they create a loop of a circuit, then the PHY
will encode and decode bits as voltages. We twist the pairs because it helps to
cancel most of the electromagnetic interference (EMI), and we can shield the
pairs for additional protection (but it costs more). The standards use the RJ-45
connector (which actually preceded ethernet, it was invented by Bell Labs for
the telecommunications industry) even if the cable uses different number of
twisted pairs. The older standards simply do not use all 8 pins of the
connector. Some routers also support swapping the connector with other ones
(SFP, SFP+..).

We have multiple twisted pair to allow for multi-lane serial communication, for
example the PHY uses one channel for transmitting and another for receiving.
But we have a problem, receiver and transmitter need to know which twisted pair
is used to transmit and which one to receive. So the convention is that the NIC
and the L2 switch use the channels in opposite ways, like UART, and use a
`straight-through` cable. However, if you have two devices which use the same
pins for transmission, you would need a `crossover cable` which crosses the
pair.

auto-MDIX
+++++++++

Today we have a feature called automatic medium-dependent interface crossover
(auto-MDIX) which is able to automatically figure out if we are using the wrong
cable, and correct its usage so we can use the same type of cables fo our entire
network.

10BASE-T and 100BASE-T use two twisted pairs, while 1000BASE-T uses 4.
1000BASE-T also uses more advanced electronics that allow both ends to transmit
and receive simultaneously on each wire pair.

Fiber
+++++

Fiber cables are based on fiberglass, which is made of a long thin string
(fiber) of flexible glass. Outer layers protect the inner layers, which are the
cladding and core. The cladding surrounds the core and its purpose is to reflect
light into the core. To transmit between two devices you need two cables, one
for each direction.

There are two types of fiber cables:

* multimode fiber which uses fiber glass with a big diameter and an led that
  emits multiple angles of light in the core of the cable. Therefore, the core
  must be bigger.

* single-mode fiber which uses a thicker fiber glass and a laser with more
  direct light. The cable costs less buy the optic costs more than the
  multimode.

Data
++++

A significant strength of the Ethernet faily of protocols is that they use the
same data-link standard (L2). The standard defined the Ethernet frame which is
composed of an Ethernet header at the front, the encapsulated data in the
middle, and an Ethernet trailer at the end.

The fields are the following:

* 7 bytes, preamble: used of synchronization

* 1 byte, Start Frame Delimeter (SFD): signifies that the next byte begins the
  Destination MAC Address field

* 6 bytes, Destination MAC Address: Identifies the intended recipient of this
  frame, with its 6 bytes long Media Access Control (MAC) address

* 6 bytes, Source MAC Address: Identifies the sender of this frame

* 2 bytes, Type: Defines the type of protocol listed inside the frame, more
  commonly it is IPv4 or IPv6. The numbers are managed by IEEE.

* 46-1500, Data and Pad: Holds data from a higher layer, typically an L3PDU. The
  sender adds padding to meet the minimum length requirement for this field (46
  bytes)

* 4 bytes, Frame Check Sequence: Provides a method for the receiving NIC to
  determine whether the frame experiences transmission errors.

Most MAC addresses represent a single NIC or other Ethernet port, so these
addresses are often called `unicast`. MAC addresses must be unique or the
network would not know exactly who to send the message at. So all NICs are
assigned an universally unique MAC address by the manufacturer. Each
manufacturer has its own 3-bytes organizationally unique identifier (OUI)
assigned by IEEE, and it assignes an unique 3 last bytes to the NIC. 6 bytes can
hold more than 281 trillion numbers, so changes of clashing are low.

The Ethernet addresses may be referred to in multiple ways, such as MAC,
burned-in address, physical address, universal address, hardware address.

IEEE defines two general categories of group addresses of Ethernet:

* Broadcast addresses: Frames sent to this address should be delivered to all
  devices on the Ethernet LAN. It has a value of `FFFF.FFFF.FFFF.FFFF`

* Multicast addresses: Frames sent to a multicast Ethernet address will be
  copied and forwarded to a subset of the devices on the LAN that volunteers to
  receive frames sent to a specific multicast address.

Via the Frame Check Sequence (FCS) Ethernet can do error detection, but not
error recovery. If an error is detected, the frame should be discarded.

Full and half duplex
++++++++++++++++++++

Modern LAN switches allow full duplex communication, meaning that it does not
have to wait to send if it is currently receiving data. Older switches, called
LAN hubs only support half-duplex communication. These data hubs operated
differently than modern switches, they were only L1 devices so they were unaware
of Ethernet. What they did is to propagate an electrical signal from one host to
all other hosts hoping that the right one would receive the signal, this means
that no two hosts could send together or there would be interference.

CSMA/CD
+++++++

To prevent collisions, hosts use a well known algorithm: the Carrier Sense
Multiple Access with Collision Detection (CSMA/CD). This covers the cases when
two hosts see the channel as clear and decide to transmit at the same time, and
other issues.

The algorithm works with the following steps:

1. A device with a frame to send listens until the Ethernet is not busy

2. When the Ethernet is not busy, the sender begins sending the frame

3. The sender listens while sending to discover whether a collision occurs;
   collisions might be caused by many reasons, including unfortunate timing. If
   a collision occurs, all currently sending nodes do the following:

  a. The send a jamming signal that tells all nodes that a collision happened

  b. They independently choose a random time to wait before trying again, to
  avoid unfurtunate timing

  c. The next attempt starts again at step 1

When you have both full duplex and half duplex hubs you need to configure the
NIC and switch port correctly. Between a PC and a swtich or between swtiches,
use full duplex. Between PC and hubs, or switches and hubs, use half duplex. The
hub itself cannot be configured, it simply repeats incoming signals out every
other port.

Note (for the exam) that the term "Ethernet Shared Media" refers to designs that
use hubs and require CSMA/CD and therefore share bandwidth. A point-to-point
network instead is built with switches.
