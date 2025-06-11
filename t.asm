#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 11 2025
#

.section .text

.globl Text

Text:
	# r8 will contain the address of the message
	# to be translated
	movq	__message(%rip), %r8
	xorq	%rax, %rax
	xorq	%rdi, %rdi
	# r9 will contain the number of bytes written
	# into __buffer so far
	xorq	%r9, %r9
.iter:
	movzbl	(%r8), %edi
	cmpb	$0, %dil
	je	.return
	call	IsMorseable
	cmpq	$0, %rax
	je	.invalid
	call	ToLower
	movq	%rax, %rdi
	call	GetOffset
	movq	%rax, %rbx
	leaq	__morse(%rip), %rax
	movq	(%rax, %rbx, 8), %rdi
	call	SaveInBuff
	jmp	.resume
.invalid:
	cmpb	$' ', %dil
	jne	.unknown
	leaq	__t2mspace(%rip), %rdi
	call	SaveInBuff
	jmp	.resume
.unknown:
	leaq	__unknown(%rip), %rdi
	call	SaveInBuff
.resume:
	incq	%r8
	jmp	.iter
.return:
	call	SpitBuff
	ret
