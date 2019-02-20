# HyperBench-A Benchmark Suite for Virtualization Capabilities

HyperBench is a set of micro-benchmarks for analyzing how much hardware mechanisms and hypervisor designs support virtualization.
HyperBench is designed and implemented from ground up as a custom kernel.
It contains 15 micro-benchmarks currently covering CPU, memory system, and I/O.
These benchmarks trigger various hypervisor-level events, such as transitions between VMs and the hypervisor, two-dimensional page walk, notification from front-end to back-end driver.

## Quick Start

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

### Unprivileged Sensitive Instruction

### Privileged Sensitive Instruction

### Exception

### Memory

### I/O



