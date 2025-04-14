.section .text
.globl _start

.include "macros.inc"

_start:
	popq	%rax
	cmpq	$3, %rax
	jnz	.print_usage
	popq	%rax								# Program's name
	popq	%rax								# Mode
	popq	%r8								# Message
	movzbl	(%rax), %eax
	cmpb	$'M', %al
	jz	.call_morse
	cmpb	$'T', %al
	jz	.call_text
.print_usage:
	PRINT	.usage_msg(%rip), .usage_len(%rip), $2
	EXIT	$-1
.call_morse:
	call	morse
.call_text:
	call	text
