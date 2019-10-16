
# HyperBench-A Benchmark Suite for Virtualization Capabilities

HyperBench is a set of micro-benchmarks for analyzing how much hardware mechanisms and hypervisor designs support virtualization.
We designed and implemented HyperBench from ground up as a custom kernel.
It contains 15 micro-benchmarks currently covering CPU, memory system, and I/O.
These benchmarks cause various hypervisor-level events, such as transitions between VMs and the hypervisor, two-dimensional page walk, notification from front-end to back-end driver.
HyperBench is aimed at quantifying those costs.

For information, please read:

Wei S, Zhang K, Tu B. HyperBench: A Benchmark Suite for Virtualization Capabilities[C]//Abstracts of the 2019 SIGMETRICS/Performance Joint International Conference on Measurement and Modeling of Computer Systems. ACM, 2019: 73-74.

Wei S, Zhang K, Tu B. HyperBench: A Benchmark Suite for Virtualization Capabilities[J]. Proceedings of the ACM on Measurement and Analysis of Computing Systems, 2019, 3(2): 24.




Table of Contents
=================

   * [HyperBench-A Benchmark Suite for Virtualization Capabilities](#hyperbench-a-benchmark-suite-for-virtualization-capabilities)
      * [Quick Start](#quick-start)
         * [Download](#download)
         * [Compiling HyperBench](#compiling-hyperbench)
         * [CPU Frequency](#cpu-frequency)
         * [Start on host machine](#start-on-host-machine)
         * [Start on QEMU-KVM](#start-on-qemu-kvm)
         * [Start on Xen](#start-on-xen)
      * [Benchmarks](#benchmarks)
         * [Idle](#idle)
         * [Sensitive Instruction](#sensitive-instruction)
         * [Virtualization Extention Instructions](#exception)
         * [Memory](#memory)
         * [I/O](#io)
      * [HyperBench kernel Details](#hyperbench-kernel-details)
         * [Initialization Before Running Benchmarks](#initialization-before-running-benchmarks)
         * [Startup Memory Layout](#startup-memory-layout)



## Quick Start

### Download
Download HyperBench into the directory /opt/.
```
# cd /opt
# git clone https://github.com/Second222None/HyperBench.git
```

### Compiling HyperBench
* If you want to run HyperBench on host machine, uncomment the **CFLAGS += -D __BARE_METAL** in the Makefile.
* If you want to run HyperBench on virtualization platforms, comment the **CFLAGS += -D __BARE_METAL** in the Makefile.

After modification, type the following instruction directly.
```
# make
```

### CPU Frequency
HyperBench measures CPU cycles using the RDTSCP instruction.
Sometimes Time Stamp Counter clock and CPU core clock are different.
What's more, to save energy the CPU chip adjusts the CPU core frequency dynamicly.
Before starting HyperBench, you would better pin the CPU at a fixed frequency to avoid the error.

### Start on host machine
1. uncomment the **CFLAGS += -D __BARE_METAL** in the Makefile.
2. The parameter **NCPU** in **include/param.h** is the number of physical cores in the host machine. Modify it according to the physical machine or the program will get stuck.
3. Copy the **out/hyperbench.64** to /boot/ directory and then adding the following entry in the grub configuration file.
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
2. [Prepare HyperBench image](https://github.com/Second222None/HyperBench/wiki/HyperBench-Image) and store the image in /opt/os
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

## HyperBench kernel Details
HyperBench kernel is designed as a standalone kernel. It can run as a test VM on various hypervisors and run directly on bare-metal.

### Initialization Before Running Benchmarks

1. When the CPU are initialized by BIOS, the bootstrap processor (BSP) begins executing the grub code. Grub calls the HyperBench kernel.
2. Since HyperBench kernel is in multiboot format, it can get the information delieverey by grub. 
3. The BSP set up a stack for itself and enter long mode. The first action of entering long mode is load the predefined global descriptor table. Then, turn on page size extension for 2Mbyte pages. Set CR3. Enables IA-32e mode operation. Turn on paging.
4. Jump into 64-bit code mode and call **main** function.
5. Get the memory layout information.
6. Enable local APIC.
7. Detect the application processors (APs). Get the APIC ID of each AP and store them in an array.
8. Initialize APs(step 3 to step 6) in serial mode.
9. Enable x2APIC.
10. Execute benchmarks one by one.

### Startup Memory Layout
Linear-Address Translation to a 2-MByte Page using 4-Level Paging.

* PML4(page map level 4): A 4-KByte naturally aligned PML4 table which is located at the physical address specified in bits 51:12 of CR3. There is only one 64-bit entry (PML4E).
* PDPT(page-directory pointers table): A 4-KByte naturally aligned page-directory-pointer table is located at the physical address specified in bits 51:12 of the PML4E. There is only 4 64-bit entries
(PDPTEs).
* PDT(page-directory table): A 4-KByte aligned PDT which is located at the physical address specified in bits 51:12 of the PDPTE. The page-directory table contains 2048 64-bit entries
(PDEs).


