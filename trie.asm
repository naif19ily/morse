#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 12 2025
#

.section .bss
	.trie: .zero 4096

.section .text

.globl TrieInit

TrieInit:	
        movl    $'*', (.trie + 16)
        # r8:  current code address
        # r9:  number of codes already used
        # r10: current code
        # r11: node
        # r12: current abc character
        # r13: r12's offset
        leaq    __morse(%rip), %r8
        xorq    %r9, %r9
        leaq    .trie(%rip), %r11
        xorq    %r12, %r12
        movl    $'a', %r12d
        movq    $0, %r13
.f0_iter:
        cmpq    $4, %r9
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
        movq    $1, %rcx
        jmp     .f0_set
.f0_right:
        movq    $2, %rcx
        jmp     .f0_set
.f0_set:
        shlq    $1, %r13
        addq    %rcx, %r13
.f0_cont:
        incq    %r10
        jmp     .f0_trie
.f0_resume: 
        leaq    .trie(%rip), %r11
        addq    %r13, %r11
        movl    %r12d, 0(%r11)
        movq    $0, %r13
        incl    %r12d
        addq    $8, %r8
        incq    %r9
        jmp     .f0_iter
.f0_ret:
        ret

.globl TrieFind

TrieFind:
        # r8: current node (root)
        # r9: looking for
        leaq    .trie(%rip), %r8
        xorq    %rax, %rax

        # a = 96
        # b = 476
        #
        # c = 

        movl    11(%r8), %eax
        cltq
        ret


        movq    %rdi, %r9
        xorq    %rdi, %rdi
.f1_iter:
        movzbl  (%r9), %edi
        cmpb    $'.', %dil
        je      .f1_left
        cmpb    $'-', %dil
        je      .f1_right
        jmp     .f1_found
.f1_left:
        movq    0(%r8), %rax
        cmpq    $0, %rax
        je      .f1_unknown
        movq    %rax, %r8
        jmp     .f1_resume
.f1_right:
        movq    8(%r8), %rax
        cmpq    $0, %rax
        je      .f1_unknown
        movq    %rax, %r8
        jmp     .f1_resume
.f1_resume:
        incq    %r9
        jmp     .f1_iter
.f1_unknown:
        movq    $0, %rax
        ret
.f1_found:
        movl    16(%r8), %edi
        movl    %edi, %eax
        cltq
        ret
