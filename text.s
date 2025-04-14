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
        movq    $1, %rax
        movq    $1, %rdi



        movq    $2, %rdx
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
