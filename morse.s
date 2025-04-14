.section .text
.globl morse

.include "macros.inc"

morse:
        # At this point R8 stores the message to be encoded
        # into morse code.
        movzbl  (%r8), %eax
        cmpb    $0, %al
        jz      .end_of_msg
.end_of_msg:
        EXIT    $0
