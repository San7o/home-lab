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

The standards are:

* 802.3 aka 10BASE-T aka Ethernet: 10Mbps, Copper, max 100m

* 802.3u aka 100BASE-T aka Fast Ethernet: 100Mbps, Copper, max 100m

* 802.3z aka 1000BASE-LX aka Gigabit Ethernet: 1000Mbps, Fiber, max 5000m

* 802.3ab aka 1000BASE-T aka Gigabit Ethernet: 1000Mbps, Copper, 100m

* 802.3an aka 10GBASE-T aka 10 Gig Ethernet: 10Gbps, Copper, 100m

The standards are always evolving, see `https://ethernetalliance.org/` for more
info.

Although Ethernet includes many physical layer standard, Ethernet acts like a
single LAN technology sending an Ethernet frame from source to destination
Ethernet node.

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
pair. Today we have a feature called automatic medium-dependent interface
crossover (auto-MDIX) which is able to automatically figure out if we are using
the wrong cable, and correct its usage so we can use the same type of cables fo
our entire network.

10BASE-T and 100BASE-T use two twisted pairs, while 1000BASE-T uses 4.
1000BASE-T also uses more advanced electronics that allow both ends to transmit
and receive simultaneously on each wire pair.

Fiber cables are based on fiberglass, which is made of a long thin string
(fiber) of flexible glass. Outer layers protect the inner layers, which are the
cladding and core. There are two types of fiber cables: multimode fiber which
uses fiber glass with a big diameter and an led, and single-mode fiber which
uses a thicker fiber glass and a laser, this is also more expensive. To transmit
between two devices you need two cables, one for each direction.
