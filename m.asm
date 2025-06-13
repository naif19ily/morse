#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 13 2025
#

.section .data
	.a: .string " %d\n"

.section .bss
	.code: .zero 8

.section .text

.include "macros.inc"

.globl Morse

Morse:
        call    TrieInit
	# r15:  message to be translated
	# r14:  current code
	# r10: number of bytes used in r14
	movq	__message(%rip), %r15
	leaq	.code(%rip), %r14
	xorq	%r10, %r10
.iter:
	xorq	%rdi, %rdi
	movzbl	(%r15), %edi
	cmpb	$0, %dil
	je	.ret
	cmpb	$'.', %dil
	je	.chr_ok
	cmpb	$'-', %dil
	je	.chr_ok
	cmpb	$' ', %dil
	je	.chr_sp
.chr_ok:
	cmpq	$5, %r10
	je	.unknown
	movb	%dil, (%r14)
	incq	%r10
	incq	%r14
	jmp	.resume
.chr_sp:
	leaq	.code(%rip), %rdi
	call	TrieFind
        CH      %rax
	movq	$0, (.code)
	leaq	.code(%rip), %r14
	xorq	%r10, %r10
	jmp	.resume
.unknown:

.resume:
	incq	%r15
	jmp	.iter	
.ret:
	ret
