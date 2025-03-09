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
	# Storing the message into r15
	# this register will contain the message
	# throughout the whole program
	movq	24(%rsp), %r15
	# Getting the mode to be used
	# `m` for going from morse to text
	# `t` for going from text to morse
	movq	16(%rsp), %rax
	movzbl	(%rax), %eax
	cmpb	$'m', %al
	je	.B01_morse_mode
	jmp	.B02_text_mode

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

.B01_morse_mode:
	jmp	.B03_tout_fini

.B02_text_mode:
	movzbl	(%r15), %edi
	cmpb	$0, %dil
	je	.B03_tout_fini
	call	FX_MORSEABLE
	cmpl	$0, %eax
	je	.B04_non_morseable
	jmp	.B05_continue
.B04_non_morseable:
	movq	$1, %rax
	movq	$1, %rdi
	movq	%r15, %rsi
	movq	$1, %rdx
	syscall
.B05_continue:
	incq	%r15
	jmp	.B02_text_mode

.B03_tout_fini:
	FINI	$0
