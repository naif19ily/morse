#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 12 2025
#

.section .bss
	.trie: .zero 512

.section .text

.globl TrieInit

TrieInit:
	# r8:  current morse code
	# r9:  number of codes indexed
	# r10: current abc letter
	# r11: current character of r8
	# r12: trie index
	leaq	__morse(%rip), %r8
	xorq	%r9, %r9
	xorq	%r10, %r10
	xorq	%r11, %r11
	xorq	%r12, %r12
.f0_iter:
	cmpq	$36, %r9
	je	.f0_ret
	movq	(%r8), %r11
.f0_trie:
	xorq	%rdi, %rdi
	movzbl	(%r11), %edi
	cmpb	$' ', %dil
	je	.f0_resume
	cmpb	$'.', %dil
	je	.f0_left
	cmpb	$'-', %dil
	je	.f0_right
.f0_left:
	movq	$1, %rcx
	jmp	.f0_upd_i
.f0_right:
	movq	$2, %rcx
	jmp	.f0_upd_i
.f0_upd_i:
	shlq	$1, %r12
	addq	%rcx, %r12
.f0_cont:
	incq	%r11
	jmp	.f0_trie
.f0_resume:
	leaq	.trie(%rip), %rax
	addq	%r12, %rax
	movb	%r10b, (%rax)
	movq	$0, %r12
	incb	%r10b
	addq	$8, %r8
	incq	%r9
	jmp	.f0_iter
.f0_ret:
	ret

.globl TrieFind

TrieFind:
	movq	%rdi, %r8
        xorq    %rax, %rax
        xorq    %rdi, %rdi
	xorq	%r9, %r9
.f1_iter:
	movzbl	(%r8), %edi
	cmpb	$'.', %dil
	je	.f1_left
	cmpb	$'-', %dil
	je	.f1_right
	jmp	.f1_ret
.f1_left:
	movq	$1, %rcx
	jmp	.f1_upd_i
.f1_right:
	movq	$2, %rcx
	jmp	.f1_upd_i
.f1_upd_i:
	shlq	$1, %r9
	addq	%rcx, %r9
.f1_resume:
	incq	%r8
	jmp	.f1_iter
.f1_ret:
	leaq	.trie(%rip), %r8
	addq	%r9, %r8
	movzbl	(%r8), %eax
	cltq
	cmpq	$0, %rax
	je	.f1_unk
	ret
.f1_unk:
	movq	$-1, %rax
        ret
