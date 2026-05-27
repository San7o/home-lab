I/O Interfaces
==============

There are several standards to communicate from / to a microcontroller.

Embedded Interfaces
-------------------

In the embedded world, the most popular interfaces are:

- UART: Universal Asynchronous Receiver / Transmitter is one of the simplest
  protocols for communication. It allows two parties to do full-duplex
  communication via 2 serial lines: RX (receive) and TX (transmit) (other than
  GND and VCC for ground and power respectively). They both need to agree to a
  baud rate to receive and transmit data correctly, it is usually set to 115200
  (measured in bits per seconds).
  
- I2C: Inter-integrated Circuit. It allows half-duplex communication between
  multiple masters and multiple slaves. It uses 2 lines, serial data line (SDA)
  and serial clock line (SCL). The master initiates coommunication and generates
  the clock.

  - SMBus is a subset of I2C. If your device supports an SMBus-compatible
    interface, then you should write a driver using the SMBus as it would be
    compatible for both SMBus and I2C.

- I2S: Inter-Integrated Circuit Sound, used for two-channel sound. You often
  have a buffer that you fill and send to the module. Lines are BCK (bit clock),
  DIN (data input) amd LCK (left-right clock, selecting the channel).

- SPI: Master-slave serial synchronous full-duplex communication. It uses 4
  lines: SS for slave select, SCLK for serial clock from the master, MOSI
  (Master Out Slave In) and MISO (Master In Slave Out).

- USB: TODO

PC Interfaces
-------------

PC moderboards have different interfaces for different speeds:

- PCI Express (PCIe): The primary expansion bus. It uses "lanes" to scale
  bandwidth for GPUs, NVMe drives, and high-speed networking cards.

- DMI (Direct Media Interface): Intel’s proprietary link (essentially a
  specialized PCIe bus) that connects the CPU to the PCH.

- Infinity Fabric: AMD’s specialized internal bus used to link different
  "chiplets" (cores and I/O dies) within the processor package.

- USB (Universal Serial Bus): A versatile bus for external devices. Modern PCs
  run multiple versions (2.0, 3.2, USB4) simultaneously.

- SATA (Serial ATA): The standard bus for mechanical hard drives and older
  2.5-inch SSDs.

- Thunderbolt / USB4: A high-speed external bus capable of "tunneling" other
  protocols like DisplayPort and PCIe over a single cable.

- DisplayPort / eDP: The dedicated video bus that carries pixel data from the
  GPU to the monitor or laptop panel.

PCs also can also support interfaces commonly found also in embedded devices,
like SMBus, UART and of course USB.

Data
----

It often happens that an external module supports one or more itnerfaces to work
with it. The interface is just how do we communicate with the piece of hardware,
another problem is what to communicate. This is fundamentally dependent on each
module, but there are some common patterns we find

- simple analog signal: sometimes the module will provide an analog signal that
  we need to convert to a digital value (ADC) and quantize it (clamp it). This
  happens for example when reading simple sensor data.

- registers: modules often provide registers that we can read and write to. The
  communication usually starts with specifying the operation we want to do (read
  or write), then which register, and then we write the data to the register, or
  read incoming data from the module.