.section .text
.globl text

.include "macros.inc"

text:
        # At this point R8 stores the message to be encoded
        # into morse code.
        movzbl  (%r8), %edi
        cmpb    $0, %dil
        jz      .end_of_msg
        call    .fx0
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
