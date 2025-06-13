#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 11 2025
#

# TODO: REMOVE THIS
.section .rodata
	.look: .string ".-."


.section .text

.globl _start

_start:
        call    TrieInit

	leaq	.look(%rip), %rdi
	call	TrieFind

	movq	%rax, %rdi
	movq	$60, %rax
	syscall

        call    ParseArgs
	cmpb	$1, (__arg_i)
	je	.go_i
	cmpb	$1, (__arg_m)
	je	.go_m
	cmpb	$1, (__arg_t)
	je	.go_t
	cmpb	$1, (__arg_E)
	je	.go_E
	cmpb	$1, (__arg_D)
	je	.go_D
	jmp	_usage
.go_i:
	movq	$60, %rax
	movq	$1, %rdi
	syscall
.go_m:
	movq	$60, %rax
	movq	$2, %rdi
	syscall
.go_t:
	call	Text
	jmp	.exit
.go_E:
	movq	$60, %rax
	movq	$4, %rdi
	syscall
.go_D:
	movq	$60, %rax
	movq	$5, %rdi
	syscall

.exit:
	movq	$60, %rax
	movq	$0, %rdi
	syscall
