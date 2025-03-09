#                __
#               / _)
#      _.----._/ /	dc0x13
#     /         /	part of `morse` project.
#  __/ (  | (  |	Mar 09 2025
# /__.-'|_|--|_|

.section .rodata
	.msg_usage: .string "usage: $ mrs [m | t] [msg]\n"
	.len_usage: .long   27

.section .text

.macro	FINI code
	movq	\code, %rdi
	movq	$60, %rax
	syscall
.endm

.globl	_start
_start:
	cmpq	$3, (%rsp)
	jne	.B00_display_usage
	FINI	$0


.B00_display_usage:
	# The program will only reach this part
	# of the code if the user provided a
	# wrong usage...
	movq	$1, %rax
	movq	$2, %rdi
	leaq	.msg_usage(%rip), %rsi
	movq	.len_usage(%rip), %rdx
	syscall
	FINI	$1
