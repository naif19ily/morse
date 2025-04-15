.section .bss
	.code: .zero	6

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
        movzbl  (%r8), %edi
        cmpb    $0, %dil
        jz      .end_of_msg
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
	PRINT	UNKNOWN_CHR_MSG(%rip), UNKNOWN_CHR_LEN(%rip), $1
	jmp	.continue
.out_code:
	# if code gets here it means a mtrse code
	# has been caught

	movq	$1, %rax
	movq	$1, %rdi
	leaq	.code(%rip), %rsi
	movq	%r10, %rdx
	syscall
	EXIT	$0


.continue:
	incq	%r8
	jmp	.loop

.end_of_msg:
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
# is an acutal morse code (.-/)
.fx0:
	movl	$1, %eax
	cmpb	$45, %dil
	je	.fx0_ret
	cmpb	$46, %dil
	je	.fx0_ret
	cmpb	$47, %dil
	je	.fx0_ret
	movl	$0, %eax
.fx0_ret:
	ret
