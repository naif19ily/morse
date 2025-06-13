#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 11 2025
#

.section .text

.include "macros.inc"

.globl IsMorseable

IsMorseable:
	movq	$1, %rax
	cmpb	$'0', %dil
	jl	.f0_no
	cmpb	$'9', %dil
	jle	.f0_ret
	cmpb	$'A', %dil
	jl	.f0_no
	cmpb	$'z', %dil
	jg	.f0_no
	cmpb	$'Z', %dil
	jle	.f0_ret
	cmpb	$'z', %dil
	jle	.f0_ret
.f0_no:
	movq	$0, %rax
.f0_ret:
	ret

.globl ToLower
ToLower:
	xorq	%rax, %rax
	cmpb	$'9', %dil
	jle	.f1_ret
	cmpb	$'Z', %dil
	jle	.f1_con
	jmp	.f1_ret
.f1_con:	
	addb	$32, %dil
.f1_ret:
	movb	%dil, %al
	ret

.globl GetOffset
GetOffset:
	cmpb	$'9', %dil
	jle	.f2_num
	subb	$'a', %dil
	jmp	.f2_ret
.f2_num:
	subb	$'0', %dil
	addb	$26, %dil
.f2_ret:
	movq	%rdi, %rax
	ret

# Whenever this function is called, the following conditions
# must be satisfaced:
# - rdi contains what is going to be stored into buffer
# - r9 is the number of bytes written so far
.globl SaveInBuff
SaveInBuff:
	xorq    %rax, %rax
	leaq	__buffer(%rip), %r10
	addq	%r9, %r10
.f3_iter:
	cmpq	$4096, %r9
	je	.f3_flush
	movzbl	(%rdi), %eax
	cmpb	$0, %al
	je	.f3_ret
	movb    %al, (%r10)
	incq	%rdi
	incq	%r9
	incq	%r10
	jmp	.f3_iter
.f3_flush:
	leaq	__buffer(%rip), %rsi
	movq	%r9, %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	movq	$0, %r9
	ret
.f3_ret:
	ret

.globl SpitBuff
SpitBuff:
	leaq	__buffer(%rip), %rsi
	# by decrementing r9 by one we remove the trailling space
	decq	%r9
	movq	%r9, %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	movq	$0, %r9
        CH      $36
	ret
