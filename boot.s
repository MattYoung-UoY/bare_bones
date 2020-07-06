/* Multi-boot header. */
.set ALIGN, 1<<0
.set MEMINFO, 1<<1
.set FLAGS, ALIGN | MEMINFO
.set MAGIC, 0x1BADB002
.set CHECKSUM, -(MAGIC+FLAGS)

.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/* Creating a stack */
.section bss
.align 16
stack_bottom:
.skip 16384 # 16 KiB
stack_top:

/* Entry point. */
.section .text
.global _start
.type _start, @function
_start:
	/* Set esp regsiter to top of the stack (x86 stacks grow downwards). */
	mov $stack_top, %esp

	/* Execute Kernel. */
	call kernel_main

	/* Disable Interrupts. */
	cli
1:	hlt

	/* Go back to halt if non-maskable interrupt occurs. */
	jmp 1b

.size _start, . - _start
