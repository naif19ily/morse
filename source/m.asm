#  _____                 
# |     |___ ___ ___ ___ 
# | | | | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|

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
        jmp     .unknown
.chr_ok:
	cmpq	$5, %r10
	je	.toolong
	movb	%dil, (%r14)
	incq	%r10
	incq	%r14
	jmp	.resume
.chr_sp:
        cmpq    $0, %r10
        je      .resume
	leaq	.code(%rip), %rdi
	call	TrieFind
        cmpq    $-1, %rax
        je      .unknown
        leaq    __abc(%rip), %rdi
        addq    %rax, %rdi
        movq    $1, %rcx
        call    SaveInBuff
	movq	$0, (.code)
	leaq	.code(%rip), %r14
	xorq	%r10, %r10
        xorq    %rdi, %rdi
.cut_spaces: 
        incq    %r15
        movzbl  (%r15), %edi
        cmpb    $' ', %dil
        je      .cut_spaces
        jmp     .iter
.unknown: 
	leaq	__unknown(%rip), %rdi
        movq    $-1, %rcx
	call	SaveInBuff
        jmp     .clean
.resume:
	incq	%r15
	jmp	.iter	
.toolong:
        xorq    %rdi, %rdi
        movzbl  (%r15), %edi
        cmpb    $' ', %dil
        je      .clean
        incq    %r15
        jmp     .toolong
.clean:
	movq	$0, (.code)
	leaq	.code(%rip), %r14
	xorq	%r10, %r10
        jmp     .resume
.ret:
        movq    $'m', %rdi
        call    SpitBuff
	ret
