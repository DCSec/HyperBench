[TOC]

# HyperBench-A Benchmark Suite for Virtualization Capabilities

HyperBench is a set of micro-benchmarks for analyzing how much hardware mechanisms and hypervisor designs support virtualization.
HyperBench is designed and implemented from ground up as a custom kernel.
It contains 15 micro-benchmarks currently covering CPU, memory system, and I/O.
These benchmarks trigger various hypervisor-level events, such as transitions between VMs and the hypervisor, two-dimensional page walk, notification from front-end to back-end driver.



## Quick Start

### Download
Download HyperBench into the directory /opt/.
```
# cd /opt
# git clone https://Second2None@bitbucket.org/Second2None/hyperbenchv2.git
```

### Compiling HyperBench
* If you want to run HyperBench on host machine, uncomment the **CFLAGS += -D __BARE_METAL** in the Makefile.
* If you want to run HyperBench on virtualization platforms, comment the **CFLAGS += -D __BARE_METAL** in the Makefile.

After modification, type the following instruction directly.
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
1. Empty the content of script/pin because Xen itself can pin vcpus in configuration file.
2. [Prepare HyperBench image](https://bitbucket.org/Second2None/hyperbenchv2/wiki/IMAGE) and store the image in /opt/os
```
# ./script/xen | host/host
```

## Benchmarks

### Idle
Idle benchmark performs two consecutive reads of the time counter. It is used to check the stability of the measurement results. Ideally, the
result is zero.

### Sensitive Instruction

#### SGDT SLDT SIDT
Store the corresponding register value into memory repeatedly.
#### PUSHF-POPF
The PUSHF and POPF instructions execute alternately on the current stack. 
The time between the first PUSHF instruction and the last POPF instruction is measured.
#### LGDT SET-CR3
Read the current value of the register during the initialization phase and load the value into the corresponding register repeatedly in the test phase.

### Exception
#### Hypercall 
Execute an instruction in the VM which leads to a transition to the hypervisor and return without doing much work in the hypervisor.
#### IPI
Issue an IPI from a CPU to another CPU which is in the halt state. 
IPI benchmark measures the time between sending the IPI until the sending CPU receives the response from the receiving CPU without
doing much work on the receiving CPU. 
In the virtualized environment, this benchmark emulates an IPI between two VCPUs running on two separate physical CPUs (PCPUs).

### Memory
#### Hot-Memory-Access
Read many different memory pages twice and the time of the second memory access is measured. The default guest page size is 4KB.
#### Cold-Memory-Access
This benchmark reserves a large portion of memory that has never been accessed before and performs one memory read at the start address of each page.
The reading over different pages eliminates TLB hits due to the prefetcher, as the prefetcher cannot access data across page
boundaries. The default guest page size is 4KB.
#### Set-Page-Table
Map the whole physical memory 1:1 to the virtual address space. This
benchmark creates a lot of page table entries, which is a frequent
operation in heavy memory allocation. The default guest page size is
4KB.
#### TLB-Shutdown
......

### I/O
#### IN
Polling and interrupt are two main approaches for notifications from
host to guest. This benchmark reads the register of the serial port
through the register I/O instructions repeatedly, which emulates the
polling mechanism.
#### OUT
OUT benchmark outputs a character to the register of the serial port
repeatedly.
#### Print
This benchmark outputs a string to the serial port through the I/O
address space, which is handled through the string I/O instructions.



