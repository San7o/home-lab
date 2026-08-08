Readelf and Objdump
===================

`readelf` and `objdump` are very useful tools to inspect ELF files. `readelf` is
a better frontend to inspect ELF specific metadata, while `objdump` is better to
disassemble code. Here I saved some important commands, and some notes on
linking.

ELF inspection
--------------

Disassemble contents of executable sections of an ELF file:

.. code-block:: bash

   obdjump -d hello.o

Read ELF file header:

.. code-block:: bash

   readelf -h hello.elf
   objdump -f hello.elf

This will tell you which type of ELF file it is. The types of files are:

* Relocatable File (ET_REL / `.o`, `.a`): Unlinked compiler output containing
  raw code sections and static relocation records. Used by the static linker
  (ld) as input building blocks to build complete programs or libraries.

* Executable File (ET_EXEC): Legacy non-PIE executable binaries with fixed
  virtual memory load addresses. Fully linked and ready to be loaded and run
  directly by the OS kernel.

* Shared Object File (ET_DYN / `.so`, PIE binaries): Position-independent
  binaries loaded into process memory at arbitrary addresses by the dynamic
  loader (ld.so). This type includes two sub-categories:

  * Shared Libraries (.so): Modular code libraries shared across multiple
    running processes.

  * PIE Executables: Modern standalone application binaries compiled with
    Position Independent Execution to support ASLR (Address Space Layout
    Randomization).

* Core Dump File (ET_CORE / core): Memory snapshots generated automatically by
  the OS kernel when a process crashes. Contains register states, thread stacks,
  and process RAM for post-mortem debugging in tools like GDB.

List section headers:

.. code-block:: bash

   readelf -S hello.elf
   objdump -h hello.elf

Symbols and Relocations
-----------------------

Relocations are addresses that the compiler does not know, so it needs to deffer
its resolution to the linker, which has visibility over all the necessary
symbols. Relocations can be jumps within a function, calls to other functions,
references to stack or global data, etc.

Show exported symbols of a relocatable file, aka the symbol table:

.. code-block:: bash

   readelf -s hello.o
   objdump -t hello.o

Symbols can be local (static) or global (exported so other relocatable files can
use them).

Show relocation table of a relocatable file:

.. code-block:: bash

   objdump -r hello.o

Here we can use readelf with `-r`, but that will also show the dynamic
relocation table.

Show contents of the dynamic symbol stable of an ELF executable:

.. code-block:: bash

   readelf --dyn-syms hello.elf
   objdump -T hello.elf

This is used both for exported symbols (used primarily by shared object, but
also ELF executables can export symbols) and for imported symbols (marked as
`UND`, undefined). These are used by the dynamic linker.

Show dynamic relocation entries of an executable:

.. code-block:: bash

   readelf -r hello.elf
   objdump -R hello.elf

From the previous four commands, we notice that there are two types of
relocations. One is done right after compilation and is call static linking
(`ld`), the other relocations are dynamically solved by a dynamic linker
(`ld-linux.so`) and is used for shared libraries.

How relocation works is that the compiler generates some placeholder values
(usually all zeroes) for offset of symbols he does not know the location of. The
compiler also generates an entry in the relocation table with the exact position
of the code that needs to be relocated, the type and size of the value, and the
symbol name. Then the linker will to do following:

* squash all sections from all object files into one big file

* look at all the relocation tables and all symbols

* patch all the values that have to be relocated with the actual offsets of the
  symbols in the squashed file.

The difference between the static linker is that the static one modifies the
binary file on disk, while the dynamic linker modifies the process memory in
RAM. Another difference is that the dynamic linker does not modify the
executable code because it is read-only in memory, so in order to resolve
dynamic relocations, it uses a layer of indirection through the `GOT` (Global
Offset Table). What happens is that the static linker patches dynamic
relocations to use offsets from the `GOT`, then the dynamic linker generates the
`GOT` with the correct values.

When using using `PIE` (position independent executable) mode, which is the
default now, then all the offsets are relative to the instruction pointer. For
symbols resolved during dynamic linking, the `GOT` is also found relative to the
instruction pointer.

If you want to see the `GOT` (which will be empty before the program is loaded):

.. code-block:: bash

   objdump -s -j .got -j .got.plt hello.elf
