#                __
#               / _)
#      _.----._/ /	dc0x13
#     /         /	part of `morse` project.
#  __/ (  | (  |	Mar 09 2025
# /__.-'|_|--|_|

.section .rodata
	.msg_usage: .string "usage: $ mrs [m | t] [msg]\n"
	.len_usage: .long   27

	.msg_unknown: .string "<?>"
	.len_unknown: .long 3

.section .text

.macro	FINI code
	movq	\code, %rdi
	movq	$60, %rax
	syscall
.endm

.macro	PRINT_EN at
	movq	$1, %rax
	movq	$1, %rdi
	leaq	ALPHA_EN(%rip), %rsi
	addq	\at, %rsi
	movq	$1, %rdx
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
	# Setting up the stack frame
	pushq	%rsp
	movq	%rsp, %rbp
	subq	$12, %rsp
	leaq	-8(%rbp), %r14
	movl	$0, -12(%rbp)
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

.B02_text_mode:
	movzbl	(%r15), %edi
	cmpb	$0, %dil
	je	.B03_tout_fini
	call	FX_MORSEABLE
	cmpl	$-1, %eax
	je	.B04_non_morseable
	cltq
	leaq	MORSE(%rip), %rsi
	movq	(%rsi, %rax, 8), %rsi
	movq	%rsi, %rdi
	call	FX_STRLEN
	movq	%rax, %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	jmp	.B05_continue
.B04_non_morseable:
	cmpl	$' ', %edi
	je	.B06_is_space
	movq	$1, %rax
	movq	$1, %rdi
	movq	%r15, %rsi
	movq	$1, %rdx
	syscall
	jmp	.B05_continue
.B06_is_space:
	PRINT_EN $38
.B05_continue:
	PRINT_EN $36
	incq	%r15
	jmp	.B02_text_mode

.B01_morse_mode:
	movzbl	(%r15), %edi
	cmpb	$0, %dil
	je	.B03_tout_fini
	# We need to check when a morse-code
	# is found, how can we tell if one is found:
	#   1. A alphabetic space is found
	#   2. The code is already 5 characters long.
	cmpl	$' ', %edi
	je	.B10_code_found
	cmpl	$5, -12(%rbp)
	je	.B10_code_found
	# If the code is not complete yet, then we
	# need to keep building it.
	call	FX_TEXTABLE
	cmpl	$0, %eax
	je	.B07_ready_texted
	# The `/` indicates a space in morse, so we
	# need to do the same but in EN.
	cmpl	$'/', %eax
	je	.B08_print_space
	# Saving the current character into the code
	# variable.
	movb	%dil, (%r14)
	incq	%r14
	incl	-12(%rbp)
	jmp	.B09_continue
.B07_ready_texted:
	# If the current character is not 
	# . - nor / it means it is already
	# a normal character
	movq	$1, %rax
	movq	$1, %rdi
	movq	%r15, %rsi
	movq	$1, %rdx
	syscall
	jmp	.B09_continue
.B08_print_space:
	PRINT_EN $36
.B09_continue:
	incq	%r15
	jmp	.B01_morse_mode
.B10_code_found:
	movq	$0, %rcx
.B10_code_found_loop:
	cmpq	$36, %rcx
	je	.B10_not_found
	leaq	-8(%rbp), %rdi
	leaq	MORSE(%rip), %rsi
	movq	(%rsi, %rcx, 8), %rsi
	call	FX_STRCMP
	cmpl	$1, %eax
	je	.B10_just_found
	incq	%rcx
	jmp	.B10_code_found_loop
.B10_just_found:
	movq	$0, -8(%rbp)
	leaq	-8(%rbp), %r14
	movl	$0, -12(%rbp)
	PRINT_EN %rcx
	jmp	.B09_continue
.B10_not_found:
	movq	$1, %rax
	movq	$1, %rdi
	leaq	.msg_unknown(%rip), %rsi
	movq	.len_unknown(%rip), %rdx
	syscall
	jmp	.B09_continue
.B03_tout_fini:
	PRINT_EN $37
	FINI	$0
