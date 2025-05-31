#  ____    __  _____  _____   ______  ______ 
# |    \  /  |/     \|     | |   ___||   ___|
# |     \/   ||     ||     \  `-.`-. |   ___|
# |__/\__/|__|\_____/|__|\__\|______||______|

.macro PRINT, msg, len, fd
	movq	$1, %rax
	movq	\fd, %rdi
	leaq	\msg, %rsi
	movq	\len, %rdx
	syscall
.endm

.macro EXIT code
	movq	\code, %rdi
	movq	$60, %rax
	syscall
.endm

.macro PRINT_SINGLE at
	leaq	ALPHA_EN(%rip), %rsi
	addq	\at, %rsi
	movq	$1, %rax
	movq	$1, %rdi
	movq	$1, %rdx
	syscall
.endm
