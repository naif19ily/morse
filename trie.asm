#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 12 2025
#

.section .bss
	.trie: .zero 4096

.section .text

.globl InitTrie

InitTrie:	
        movl    $'*', (.trie + 16)
        # r8:  current code address
        # r9:  number of codes already used
        # r10: current code
        # r11: node
        # r12: current abc character
        leaq    __morse(%rip), %r8
        xorq    %r9, %r9
        leaq    .trie(%rip), %r11
        movq    $'a', %r12
.f0_iter:
        cmpq    $36, %r9
        je      .f0_ret 
        movq    (%r8), %r10
.f0_trie:
        xorq    %rdi, %rdi
        movzbl  (%r10), %edi
        cmpb    $' ', %dil
        je      .f0_resume
        cmpb    $'.', %dil
        je      .f0_left
        cmpb    $'-', %dil
        je      .f0_right
.f0_left:
        movq    (%r11), %rax
        cmpq    $0, %rax
        jne     .f0_cont
        movq    $8, %rbx
        jmp     .f0_set
.f0_right:
        movq    8(%r11), %rax
        cmpq    $0, %rax
        jne     .f0_cont
        movq    $8, %rbx
        jmp     .f0_set
.f0_set:
        movq    $0, (%r11)
        movq    $0, 8(%r11)
        movl    $0, 16(%r11)
        leaq    (%r11, %rbx), %rax
.f0_cont:
        movq    %rax, %r11
        incq    %r10
        jmp     .f0_trie
.f0_resume: 
        movl    %r12d, 16(%r11)
        addq    $8, %r8
        incq    %r9
        jmp     .f0_iter
.f0_ret:
        ret
