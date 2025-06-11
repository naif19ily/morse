#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 11 2025
#

.section .text

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

.globl WriteBuff
WriteBuff: 
        
