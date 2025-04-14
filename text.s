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

        movq    $1, %rax
        movq    $1, %rdi
        movq    %r8, %rsi
        movq    $1, %rdx
        syscall

        jmp     .continue


.no_mrsbl:

.continue:
        incq    %r8
        jmp     .text
        

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


# Checks if a character can be translated into
# a morse representation
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
