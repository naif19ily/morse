.section .text
.globl text

.include "macros.inc"

text:
.text
        # At this point R8 stores the message to be encoded
        # into morse code.
        movzbl  (%r8), %edi
        cmpb    $0, %dil
        jz      .end_of_msg
        call    .fx0
        cmpl    $0, %eax
        je      .no_mrsbl
        call    .fx1
        subl    $97, %eax
        # At this point the code to be printed is stored into
        # eax as an offset.
        cltq
        leaq    MORSE(%rip), %rbx
        movq    (%rbx, %rax, 8), %rsi
        movq    %rsi, %rdi                                                              # rsi is the code
        call    .fx2
        movq    %rax, %rdx
        movq    $1, %rax
        movq    $1, %rdi
        syscall
        jmp     .continue
.no_mrsbl:
	cmpb	$32, %dil
	je	.pnt_spc
	PRINT	UNKNOWN_CHR_MSG(%rip), UNKNOWN_CHR_LEN(%rip), $1
	jmp	.continue
.pnt_spc:
	PRINT_SINGLE $38
.continue:
	PRINT_SINGLE $36
        incq    %r8
        jmp     .text
.end_of_msg:
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


# Checks if a character can be translated into
# a morse representation, accpeted (A-Za-z)
.fx0:
        movl    $0, %eax
        cmpb    $65, %dil
        jl      .fx0_ret
        cmpb    $122, %dil
        jg      .fx0_ret
        movl    $1, %eax
        cmpb    $91, %dil
        jl      .fx0_ret
        cmpb    $96, %dil
        jg      .fx0_ret
        movl    $0, %eax
.fx0_ret:
        ret

# Converts upper-case character into its lower-case version
.fx1:
        cmpb    $96, %dil
        jg      .fx1_ret
        addl    $32, %edi
.fx1_ret:
        movl    %edi, %eax
        ret

# Calculates the length of a string
.fx2:
        movq    $0, %rcx
.fx2_loop:
        movzbl  (%rdi), %eax
        cmpb    $0, %al
        jz      .fx2_ret
        incq    %rdi
        incq    %rcx
        jmp     .fx2_loop
.fx2_ret:
        movq    %rcx, %rax
        ret
