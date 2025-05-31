#  ____    __  _____  _____   ______  ______ 
# |    \  /  |/     \|     | |   ___||   ___|
# |     \/   ||     ||     \  `-.`-. |   ___|
# |__/\__/|__|\_____/|__|\__\|______||______|

.section .bss
	.code: .zero 6

.section .text
.globl morse

.include "macros.inc"

morse:
	# r9  register will hold the code being constructed
	# r10 register will hold the code's length
	leaq	.code(%rip), %r9
	movq	$0, %r10
.loop:
	# At this point R8 stores the message to be encoded
	# into morse code.
	movzbl	(%r8), %edi
	cmpb	$0, %dil
	jz	.c_fini
	call	.fx0
	cmpl	$0, %eax
	je	.no_mrs
	# The maximum length is 5 bytes, long any beyond that
	# means nothing in morse code
	cmpq	$5, %r10
	je	.out_code
	movb	%dil, (%r9)
	incq	%r10
	incq	%r9
	jmp	.continue
.no_mrs:
	cmpb	$32, %dil
	je	.out_code
	cmpb	$47, %dil
	je	.ptn_space
	PRINT	UNKNOWN_ERR_MSG(%rip), UNKNOWN_ERR_LEN(%rip), $1
	jmp	.continue
.out_code:
	# Time to see if what we just got is an acutal morse code
	movq	$0, %rcx
.out_code_seek:
	cmpq	$36, %rcx
	je	.out_code_404
	leaq	.code(%rip), %r15
	leaq	MORSE(%rip), %rax
	movq	(%rax, %rcx, 8), %r14
	call	.fx2
	cmpl	$1, %eax
	je	.out_code_put
	incq	%rcx
	jmp	.out_code_seek
.out_code_put:
	PRINT_SINGLE %rcx
	movq	$0, %r10
	movq	$0, .code(%rip)
	leaq	.code(%rip), %r9
	jmp	.continue
.out_code_404:
	PRINT	UNKNOWN_ERR_MSG(%rip), UNKNOWN_ERR_LEN(%rip), $1
	jmp	.continue
.ptn_space:
	PRINT_SINGLE $36
	incq	%r8
.continue:
	incq	%r8
	jmp	.loop
.c_fini:
	PRINT_SINGLE $37
        EXIT    $0

#  ________________
# < util functions >
#  ----------------
#         \   ^__^
#          \  (oo)\_______
#             (__)\       )\/\
#                 ||----w |
#                 ||     ||

# Makes sure the current character stored into rdi
# is an acutal morse code (. or -)
.fx0:
	movl	$1, %eax
	cmpb	$45, %dil
	je	.fx0_ret
	cmpb	$46, %dil
	je	.fx0_ret
	movl	$0, %eax
.fx0_ret:
	ret

# Calculates the length of a string (REPEATED I KNOW, RIEN A FOUTRE)
.fx1:
	movq	$0, %rbx
.fx1_loop:
	movzbl	(%rdi), %eax
	cmpb	$0, %al
	jz	.fx1_ret
	incq	%rdi
	incq	%rbx
	jmp	.fx1_loop
.fx1_ret:
	movq	%rbx, %rax
	ret

# Checks if two strings are equal
.fx2:
	movq	%r14, %rdi
	call	.fx1
	cmpq	%rax, %r10
	jne	.fx2_neq
.fx2_iter:
	movzbl	(%r14), %eax
	cmpb	$0, %al
	je	.fx2_eq
	cmpb	%al, (%r15)
	jne	.fx2_neq
	incq	%r15
	incq	%r14
	jmp	.fx2_iter
.fx2_eq:
	movl	$1, %eax
	ret
.fx2_neq:
	movl	$0, %eax
	ret
