.globl __fast_zero_page
__fast_zero_page:
	xor %eax, %eax
	mov $0x200, %ecx
	cld
	rep stosq %rax, %es:(%rdi)
	ret

