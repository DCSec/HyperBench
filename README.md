# HyperBench-A Benchmark Suite for Virtualization Capabilities

## Introduction
HyperBench is a set of micro-benchmarks for analyzing how much hardware mechanisms and hypervisor designs support virtualization.
HyperBench is designed and implemented from ground up as a custom kernel.
It contains 15 micro-benchmarks currently covering CPU, memory system, and I/O. 
These benchmarks trigger various hypervisor-level events, such as transitions between VMs and the hypervisor, two-dimensional page walk, notification from front-end to back-end driver.

## Architecture
The HyperBench is designed to support multiple architectures; currently x86\_64 only. All benchmarks share the underlying API and drivers.

## Quick Start
### Compiling HyperBench
If you want to run HyperBench on host machine, uncomment the **\_\_BARE\_METAL** macro definitions in include/defs.h. Otherwise, type the following instruction directly.
```
# make
```

### Start on host machine
Using GRUB 2, you can boot HyperBench kernel from a file stored in a Linux file system by copying kernel to /boot/ directory and then adding the following entry.
```
menuentry 'HyperBench'{
     insmod part_msdos
     insmod ext2
     set root='hd0,msdos1'
     multiboot /boot/hyperbench.64
}
```
### Start on QEMU-KVM
Enter HyperBench directory and run the following script.
```
# qemu-system-x86_64 -enable-kvm -smp 2 -m 4096 -kernel out/hyperbench.32 -nographic | host/host
```
### Start on Xen
1. Rename script/pin because Xen can pin vcpus in configuration file.
2. Run the script/os(doing) to prepare the os.img.
3. There is a script in the script/ directory named xen.
4. Make sure /opt/os exists before running the following command.
```
# ./script/xen | host/host
```

## Appendix

### The boot page table
Linear-Address Translation to 2-MByte Pages using 4-Level Paging(1:1)

- ptl2: 2MB \* 2048 page tables entries. Each page table entry is 8Bytes. 4 pages.
- ptl3: 4 page table entries and each points to a ptl3 page.
- ptl4: 1 page table entry that points to ptl3.

### [Multiboot Specification](https://www.gnu.org/software/grub/manual/multiboot/multiboot.html)

**Getting the memory map of the machine provided by the BIOS**



### [MultiProcessor Specification](https://en.wikipedia.org/wiki/MultiProcessor_Specification)

**Detecting the number of PCPU**

- Search for the MP Floating Pointer Structure, which according to **MultiProcessor Specification** is in one of the following three locations:
     1. in the first KB of the EBDA;
     2. in the last KB of system base memory;
     3. in the BIOS ROM between 0xE0000 and 0xFFFFF.
- Search for an MP configuration table.

### [BDA](http://staff.ustc.edu.cn/~xyfeng/research/cos/resources/machine/mem.htm)
当计算机通电时，BIOS数据区（BIOS Data Area）将在000400h处创建。它长度为256字节（000400h - 0004FFh），包含有关系统环境的信息。该信息可以被任何程序访问和更改。计算机的大部分操作由此数据控制。此数据在启动过程中由POST（BIOS开机自检）加载。

如果EBDA（Extended BIOS Data Area,扩展BIOS数据区）不存在，BDA[0x0E]和BDA[0x0F]的值为0；如果EBDA存在，其段地址被保存在BDA[0x0E]和BDA[0x0F]中，其中BDA[0x0E]保存EBDA段地址的低8位，BDA[0x0F]保存EDBA段地址的高8位，所以(BDA[0x0F] << 8) | BDA[0x0E]就表示了EDBA的段地址，将段地址左移4位即为EBDA的物理地址。在HyperBench中，BDA[0x0F]=0x9F，BDA[0x0E]=0xC0，所以EBDA存在且段地址为0x9FC0，物理地址为0x9FC00。


