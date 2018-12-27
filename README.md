# HyperBench

## Description
HyperBench - A Benchmark Suite for Virtualization Capabilities

HyperBench is a custom kernel designed to trigger various hypervisor-level events, such as transitions between VMs and the hypervisor, two-dimensional page walk, notification from front-end to back-end driver.

## Appendix
### BDA
当计算机通电时，BIOS数据区（BIOS Data Area）将在000400h处创建。它长度为256字节（000400h - 0004FFh），包含有关系统环境的信息。该信息可以被任何程序访问和更改。计算机的大部分操作由此数据控制。此数据在启动过程中由POST（BIOS开机自检）加载。

如果EBDA（Extended BIOS Data Area,扩展BIOS数据区）不存在，BDA[0x0E]和BDA[0x0F]的值为0；如果EBDA存在，其段地址被保存在BDA[0x0E]和BDA[0x0F]中，其中BDA[0x0E]保存EBDA段地址的低8位，BDA[0x0F]保存EDBA段地址的高8位，所以(BDA[0x0F] << 8) | BDA[0x0E]就表示了EDBA的段地址，将段地址左移4位即为EBDA的物理地址。在HyperBench中，BDA[0x0F]=0x9F，BDA[0x0E]=0xC0，所以EBDA存在且段地址为0x9FC0，物理地址为0x9FC00。
### MultiProcessor Specification

[MultiProcessor Specification](https://en.wikipedia.org/wiki/MultiProcessor_Specification)

**检测CPU个数**
- Search for the MP Floating Pointer Structure, which according to **MultiProcessor Specification** is in one of the following three locations:
 1) in the first KB of the EBDA;
 2) in the last KB of system base memory;
 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
- Search for an MP configuration table.

### Multiboot Specification

[Multiboot Specification version 0.6.96](https://www.gnu.org/software/grub/manual/multiboot/multiboot.html)

Get the memory map of the machine provided by the BIOS


