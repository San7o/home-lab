Memory Technologies
===================

Types of memories:

Volatile
--------

* `Static RAM` (SRAM): Volatile memory that uses a six-transistor (6T) cell design
  to latch data; it is extremely fast, byte-addressable, does not require
  refreshing, and is primarily used for CPU L1/L2/L3 caches.

* `Dynamic RAM` (DRAM): Volatile main memory that stores data in capacitors which
  naturally leak charge; it requires continuous electrical refreshing, operates
  with high density at a lower cost than SRAM, and requires complex timing
  initialization at boot.

Non volatile
------------

* `NOR Flash`: Non-volatile memory utilizing parallel floating-gate transistor
  architecture; it is byte-addressable for reads, supports Execute In Place
  (XIP) directly from the memory bus, offers high read speeds, and is typically
  used for system BIOS and bootloaders.

* `NAND Flash`: Non-volatile memory utilizing series floating-gate or
  charge-trap architectures; it is strictly block-addressable (reads/writes in
  pages, erases in blocks), lacks XIP capability, offers massive density at low
  cost, and forms the basis of modern SSDs, M.2 drives, and SD cards.

* `Mask ROM`: Non-volatile memory with data physically and permanently etched
  into the silicon during semiconductor fabrication; it cannot be modified under
  any circumstances and is used for low-level SoC factory Boot ROMs.

* `EEPROM`: Non-volatile, electrically erasable programmable read-only memory
  that allows data to be erased and rewritten byte by byte; it is slow and has
  low density, making it suitable for storing small configuration metrics or
  device serial numbers.

* `Phase-Change Memory` (PCM / PRAM): Emerging non-volatile memory that stores
  data by altering the physical state of chalcogenide glass between crystalline
  (conductive) and amorphous (resistive) phases; it bridges the gap between DRAM
  and NAND by offering near-DRAM read speeds and byte-addressability.

* `Magnetoresistive RAM` (MRAM): Emerging non-volatile memory that stores data
  using magnetic storage elements (magnetic tunnel junctions) rather than
  electric charge; it delivers high endurance, low power consumption, and
  near-SRAM operational speeds.
