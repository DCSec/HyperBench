
# Using GRUB 2, you can boot HyperBench kernel from a file stored in a
# Linux file system by copying kernel to /boot
# and then adding this entry

# menuentry 'HyperBench'{
#     insmod part_msdos
#     insmod ext2
#     set root='hd0,msdos1'
#     multiboot /boot/hyperbench.64
# }

#include "asm.h"
#include "memlayout.h"
#include "mmu.h"
#include "param.h"

#define MULTIBOOT_HEADER_MAGIC 0x1BADB002
#define MULTIBOOT_HEADER_FLAGS 0x00000000

//.globl boot_idt
//.globl idt_descr
.globl gdt64_desc

//boot_idt = 0

.code32
# multiboot header
        .long MULTIBOOT_HEADER_MAGIC
        .long MULTIBOOT_HEADER_FLAGS
        .long -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)

# By convention, the "start" symbol specifies the ELF entry point.
# Since we haven't set up virtual memory yet, our entry point is
# the physical address of '_start'.
//.globl _start
//_start = V2P_WO(entry)

# Entering HyperBench kernel on boot processor, with paging off.

.globl entry
entry:
	mov %ebx, mb_boot_info
	mov %eax, mb_magic
        mov $stacktop, %esp
	call prepare_64
	jmpl $8, $start64

prepare_64:
        lgdt gdt64_desc

enter_long_mode:
	# Turn on page size extension for 4Mbyte pages
	mov %cr4, %eax
	bts $5, %eax
	mov %eax, %cr4
	# Set page directory
//	mov $(V2P_WO(entrypml4e)), %eax
	mov pt_root, %eax
	mov %eax, %cr3

# IA32_EFER.LME = 1, Enables IA-32e mode operation.
efer = 0xC0000080
	mov $efer, %ecx
	rdmsr
	bts $8, %eax
	wrmsr

	# Turn on paging
	mov %cr0, %eax
        bts $0, %eax
        bts $31, %eax
        mov %eax, %cr0
        ret

.code64

start64:
//	lidtq idt_descr
	mov mb_boot_info(%rip), %rbx
        mov %rbx, %rdi
	mov mb_magic(%rip), %rbx
	mov %rbx, %rsi
//	call sipi_entry_mov
	call main

/***********************************************************************/
smp_stacktop:	.long 0xa0000
.code16
sipi_entry:
	mov %cr0, %eax
	or $1, %eax
	mov %eax, %cr0
	lgdtl gdt32_descr - sipi_entry
	ljmpl $8, $ap_start32

gdt32_descr:
	.word gdt32_end -gdt32 -1
	.long gdt32

gdt32:
	.quad 0
	.quad 0x00cf9b000000ffff // flat 32-bit code segment
	.quad 0x00cf93000000ffff // flat 32-bit data segment
gdt32_end:

sipi_end:

.code32
ap_start32:
	# Set up the protected-mode data segment registers
	mov    $(SEG_KDATA<<3), %ax    # Our data segment selector
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs
	mov %ax, %ss
	mov $-4096, %esp
	lock/xaddl %esp, smp_stacktop
	call prepare_64
	ljmpl $8, $ap_start64

.code64
ap_start64:
	call mpenter
	sti   // Enable external Interrupt
	nop
1:
	hlt
	jmp 1b

.globl sipi_entry_mov
sipi_entry_mov:
	cld
	lea sipi_entry, %rsi
	xor %rdi, %rdi
	mov $(sipi_end - sipi_entry), %rcx
	rep/movsb
//	call DEBUG
	ret

/***********************************************************************/
.data

pt_root:        .quad ptl4
mb_boot_info:   .quad 0
mb_magic:	.quad 0

//idt_descr:
//        .word 16 * 256 - 1
//        .quad boot_idt

/* Linear-Address Translation to a 2-MByte Page using 4-Level Paging */
.align 4096
.globl ptl2
ptl2:
i = 0
	.rept 512 * 4
	.quad 0x1e7 | (i << 21)
	i = i + 1
	.endr

.align 4096
ptl3:
	.quad ptl2 + 7 + 0 * 4096
	.quad ptl2 + 7 + 1 * 4096
	.quad ptl2 + 7 + 2 * 4096
	.quad ptl2 + 7 + 3 * 4096

.align 4096
ptl4:
	.quad ptl3 + 7

.align 4096


gdt64_desc:
        .word gdt64_end - gdt64 - 1 
        .quad gdt64

gdt64:
        .quad 0
        .quad 0x00af9b000000ffff // 64-bit code segment, selector = 0x08
        .quad 0x00cf93000000ffff // 32/64-bit data segment, selector = 0x10
        .quad 0x00af1b000000ffff // 64-bit code segment, not present, 0x18
        .quad 0x00cf9b000000ffff // 32-bit code segment, 0x20
        .quad 0x008f9b000000FFFF // 16-bit code segment, 0x28
        .quad 0x008f93000000FFFF // 16-bit data segment, 0x30
        .quad 0x00cffb000000ffff // 32-bit code segment (user), 0x38
        .quad 0x00cff3000000ffff // 32/64-bit data segment (user), 0x40
        .quad 0x00affb000000ffff // 64-bit code segment (user), 0x48
/* 6 spare selectors */
	.word 0xffff, 0x0, 0x9200, 0x00cf // IDT Selector, 0x50
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0
gdt64_end:

/*******************************************************************************/
max_cpus = 64
.align 4096
.bss
	. = . + 4096 * max_cpus
	.align 16
stacktop:
        . = . + 4096
        .align 16
ring0stacktop:





