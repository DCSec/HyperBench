#include "asm.h"
#include "memlayout.h"
#include "mmu.h"
	
# Each non-boot CPU ("AP") is started up in response to a STARTUP
# IPI from the boot CPU.  Section B.4.2 of the Multi-Processor
# Specification says that the AP will start in real mode with CS:IP
# set to XY00:0000, where XY is an 8-bit value sent with the
# STARTUP. Thus this code must start at a 4096-byte boundary.
#
# Because this code sets DS to zero, it must sit
# at an address in the low 2^16 bytes.
#
# Startothers (in main.c) sends the STARTUPs one at a time.
# It copies this code (start) at 0x7000.  It puts the address of
# a newly allocated per-core stack in start-4,the address of the
# place to jump to (mpenter) in start-8, and the physical address
# of entrypgdir in start-12.
#
# This code combines elements of bootasm.S and entry.S.

.code16           
.globl start
start:
  cli            

  # Zero data segment registers DS, ES, and SS.
  xorw    %ax,%ax
  movw    %ax,%ds
  movw    %ax,%es
  movw    %ax,%ss

  # Switch from real to protected mode.  Use a bootstrap GDT that makes
  # virtual addresses map directly to physical addresses so that the
  # effective memory map doesn't change during the transition.
  lgdt    gdtdesc
  movl    %cr0, %eax
  orl     $CR0_PE, %eax
  movl    %eax, %cr0

  # Complete the transition to 32-bit protected mode by using a long jmp
  # to reload %cs and %eip.  The segment descriptors are set up with no
  # translation, so that the mapping is still the identity mapping.
  ljmpl    $(SEG_KCODE<<3), $(start32)

//PAGEBREAK!
.code32  # Tell assembler to generate 32-bit code now.
start32:
  # Set up the protected-mode data segment registers
  movw    $(SEG_KDATA<<3), %ax    # Our data segment selector
  movw    %ax, %ds                # -> DS: Data Segment
  movw    %ax, %es                # -> ES: Extra Segment
  movw    %ax, %ss                # -> SS: Stack Segment
  movw    $0, %ax                 # Zero segments not ready for use
  movw    %ax, %fs                # -> FS
  movw    %ax, %gs                # -> GS

prepare_64:
  lgdt gdt64_desc
  # Turn on page size extension for 2Mbyte pages
  mov %cr4, %eax
  orl $(CR4_PSE), %eax
  mov %eax, %cr4

efer = 0xC0000080
  mov $efer, %ecx
  rdmsr
  bts $8, %eax
  wrmsr

  # Use entrypgdir as our initial page table
  movl    (start-24), %eax
  movl    %eax, %cr3

  # Turn on paging.
  movl    %cr0, %eax
  orl     $(CR0_PE|CR0_PG), %eax
  movl    %eax, %cr0

  ljmpl $8, $ap_start64


.code64
ap_start64:

  # Switch to the stack allocated by startothers()
  movl    (start-8), %esp
  # Call mpenter()
  call	 *(start-16)

  movw    $0x8a00, %ax
  movw    %ax, %dx
  outw    %ax, %dx
  movw    $0x8ae0, %ax
  outw    %ax, %dx
spin:
  hlt
  jmp     spin

.p2align 2
gdt:
  .quad 0
  SEG_ASM(STA_X|STA_R, 0, 0xffffffff)
  SEG_ASM(STA_W, 0, 0xffffffff)


gdtdesc:
  .word   (gdtdesc - gdt - 1)
  .long   gdt

gdt64:
	.quad 0
	.quad 0x00af9b000000ffff // 64-bit code segment
	.quad 0x00cf93000000ffff // 32/64-bit data segment
	.quad 0x00af1b000000ffff // 64-bit code segment, not present
	.quad 0x00cf9b000000ffff // 32-bit code segment
	.quad 0x008f9b000000FFFF // 16-bit code segment
	.quad 0x008f93000000FFFF // 16-bit data segment
	.quad 0x00cffb000000ffff // 32-bit code segment (user)
	.quad 0x00cff3000000ffff // 32/64-bit data segment (user)
	.quad 0x00affb000000ffff // 64-bit code segment (user)

	.quad 0			 // 6 spare selectors
	.quad 0
	.quad 0
	.quad 0
	.quad 0
	.quad 0

gdt64_end:

gdt64_desc:
	.word gdt64_end - gdt64 - 1
	.quad gdt64


