#  _____                 
# |     |___ ___ ___ ___ 
# | | | | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|

.macro CH at
	leaq	__abc(%rip), %rsi
	addq	\at, %rsi
	movq	$1, %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
.endm
