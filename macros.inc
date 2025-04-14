.macro	PRINT msg, len, fd
	movq	\len, %rdx
	leaq	\msg, %rsi
	movq	\fd, %rdi
	movq	$1, %rax
	syscall
.endm

.macro	EXIT code
	movq	\code, %rdi
	movq	$60, %rax
	syscall
.endm
