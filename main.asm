#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 11 2025
#

.section .text

.globl _start

_start:
        call    ParseArgs
	movq	$60, %rax
	movq	$0, %rdi
	syscall
