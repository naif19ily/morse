#  _____                 
# |     |___ ___ ___ ___ 
# | | | | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|

.section .bss
	.bufw: .zero 8

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
# - rcx is the numbe of bytes to write (-1 if not known)
.globl SaveInBuff
SaveInBuff:
	xorq	%rbx, %rbx
	xorq    %rax, %rax
	leaq	__buffer(%rip), %r10
	addq	.bufw(%rip), %r10
.f3_iter:
	cmpq	$4096, %r9
	je	.f3_flush
	cmpq	%rcx, %rbx
	je	.f3_ret
	movzbl	(%rdi), %eax
	cmpb	$0, %al
	je	.f3_ret
	movb    %al, (%r10)
	incq	%rdi
	incq	(.bufw)
	incq	%r10
	incq	%rbx
	jmp	.f3_iter
.f3_flush:
	leaq	__buffer(%rip), %rsi
	movq	(.bufw), %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	movq	$0, (.bufw)
	ret
.f3_ret:
	ret

.globl SpitBuff
SpitBuff:
	# by decrementing r9 by one we remove the trailling space
	# only for text mode (specified in rdi)
	cmpq	$'t', %rdi
	jne	.f4_cont
	decq	(.bufw)
.f4_cont:
	leaq	__buffer(%rip), %rsi
	movq	(.bufw), %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	movq	$0, (.bufw)
        CH      $36
	ret
