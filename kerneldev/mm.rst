Memory Management
=================

A great book to understand memory management is "The Linux Memory Manager" by
Lorenzo Stoakes (maintainer of the mm subsystem).

There is also `this youtube channel`_ with interesting videos.

.. _this youtube channel: https://www.youtube.com/watch?v=j4rMF6kDdDo

Physical Memory
---------------

Physical memory describes all of the memory on a system which can be addressed
arbitrarily by at least one core. Physical memory is represented by the
`phys_addr_t` type and is divided into blocks called `pages`, each one of
`PAGE_SIZE` bytes (which is the hardware minimum supported page size depending
on the architecture). We hay have multiple CPU sockets with some memory attached
to a CPU and some other memory on another CPU. These systems are said to have
non-uniform memory access (NUMA). Therefore, we divide the memory into
physically continuous `nodes` (a page belongs to one and only one node), which
are further divided into `ranges` known as `zones` (which may overlap nodes).
For efficiency, the kernel allocates memory in power-of-two number of pages at a
time, with the `order` of an allocated page being equal to the power number (an
order-3 allocation consists of 2^3 pages). Each base page of physical memory has
metadata associated with it, stored in a `struct page` object, with aggregate
blocks of one or more base pages represented as a `struct folio` object. A *page
frame number* is the physical address divided by the page size. Memory is
further divided into `page blocks` of order `pageblock_order` (9 on x86-64),
which are the smallest number of pages which can have a `migraty type` applied
to them so they can be `migrated` i.e. moved around.
