#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 11 2025
#

.section .data
	__arg_t: .byte 0
	__arg_m: .byte 0
	__arg_i: .byte 0
	__arg_E: .byte 0
	__arg_D: .byte 0

	.globl __arg_t
	.globl __arg_m
	.globl __arg_i
	.globl __arg_E
	.globl __arg_D

.section .bss
	__message:  .zero 8
	__filename: .zero 8

	.globl __message
	.globl __filename

.section .text


# Makes sure there's one more argument given, if there is,
# then it sets r8 to such argument, otherwise throws an error
.macro GETARG
	incq	%rcx
	cmpq	8(%rsp), %rcx
	je	_fatal_2
	movq	16(%rsp, %rcx, 8), %r8
.endm

.globl ParseArgs

ParseArgs:
	# Getting the number of arguments given
	movq	8(%rsp), %rax
	cmpq	$1, %rax
	je	.return
	movq	$1, %rcx
.iter:
	cmpq	8(%rsp), %rcx
	jge	.return
	# getting current argument
	movq	16(%rsp, %rcx, 8), %rax
	movzbl	(%rax), %eax
	cmpb	$'t', %al
	je	.t_op
	cmpb	$'m', %al
	je	.m_op
	cmpb	$'D', %al
	je	.D_op
	cmpb	$'E', %al
	je	.E_op
	cmpb	$'i', %al
	je	.i_op
	jmp	_fatal_1
.t_op:
	GETARG
	movb	$1, (__arg_t)
	movq	%r8, (__message)
	jmp	.resume
.m_op:
	GETARG
	movb	$1, (__arg_m)
	movq	%r8, (__message)
	jmp	.resume
.E_op:
	GETARG
	movb	$1, (__arg_E)
	movq	%r8, (__filename)
	jmp	.resume
.D_op:
	GETARG
	movb	$1, (__arg_D)
	movq	%r8, (__filename)
	jmp	.resume
.i_op:
	movb	$1, (__arg_i)
.resume:
	incq	%rcx
	jmp	.iter
.return:
	ret
