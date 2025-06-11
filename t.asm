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
.iter:
	movzbl	(%r8), %edi
	cmpb	$0, %dil
	je	.return
	call	IsMorseable
	cmpq	$0, %rax
	je	.invalid
	call	ToLower


	jmp	.resume
.invalid:

.resume:
	incq	%r8
	jmp	.iter
.return:
	ret
