#  _____                 
# |     |___ ___ ___ ___ 
# | | | | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|

.section .text

.globl _usage
.globl _fatal_1
.globl _fatal_2

_usage:
	movq	$60, %rax
	movq	$0, %rdi
	syscall

# unknown option in arguments
_fatal_1:
	movq	$60, %rax
	movq	$-1, %rdi
	syscall

# option is missing argument
_fatal_2:
	movq	$60, %rax
	movq	$-2, %rdi
	syscall
