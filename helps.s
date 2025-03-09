#                __
#               / _)
#      _.----._/ /	dc0x13
#     /         /	part of `morse` project.
#  __/ (  | (  |	Mar 09 2025
# /__.-'|_|--|_|

.globl	FX_MORSEABLE
.globl	FX_STRLEN
.globl	FX_TEXTABLE
.globl	FX_STRCMP

# Tells if the current character (%rdi) is a lower
# case character.
FX_IS_LOWER:
	movl	$0, %eax
	cmpl	$'a', %edi
	jl	.A00_return
	cmpl	$'z', %edi
	jg	.A00_return
	movl	$1, %eax
.A00_return:
	ret

# Tells if the current character (%rdi) is a upper
# case character.
FX_IS_UPPER:
	movl	$0, %eax
	cmpl	$'A', %edi
	jl	.A00_return
	cmpl	$'Z', %edi
	jg	.A00_return
	movl	$1, %eax
.B00_return:
	ret

# Tells if the current character (%rdi) is a
# didgit (0 - 9).
FX_IS_DIGIT:
	movl	$0, %eax
	cmpl	$'0', %edi
	jl	.A00_return
	cmpl	$'9', %edi
	jg	.A00_return
	movl	$1, %eax
.C00_return:
	ret

# Cheks if the current character (%rdi) can be turned into
# a morse character, if so, then it will get its position
# within the `MORSE` array defined in `alpha.s`
FX_MORSEABLE:
	call	FX_IS_LOWER
	cmpl	$1, %eax
	je	.D01_ok
	call	FX_IS_UPPER
	cmpl	$1, %eax
	je	.D01_as_upp
	call	FX_IS_DIGIT
	cmpl	$1, %eax
	je	.D01_as_dig
	jmp	.D00_return
.D01_as_dig:
	subl	$'0', %edi
	addl	$27, %edi
	movl	%edi, %eax
	ret
.D01_as_upp:
	addl	$32, %edi
.D01_ok:
	subl	$'a', %edi
	movl	%edi, %eax
	ret
.D00_return:
	movl	$-1, %eax
	ret

# Calculates the length of a string
# NOTE: uses rcx
FX_STRLEN:
	movq	$0, %rcx
.E00_loop:
	cmpb	$0, (%rdi)
	je	.E01_return
	incq	%rdi
	incq	%rcx
	jmp	.E00_loop
.E01_return:
	movq	%rcx, %rax
	ret

# Tells if the current character (%rdi) is a morse
# character a.k.a. - . /
FX_TEXTABLE:
	cmpl	$'.', %edi
	je	.F00_return
	cmpl	$'-', %edi
	je	.F00_return
	cmpl	$'/', %edi
	je	.F00_return
	movl	$0, %edi
.F00_return:
	movl	%edi, %eax
	ret

# Compares two strings and returns 1 if they're
# equal, 0 otherwise
FX_STRCMP:
.G00_loop:
	movzbl	(%rdi), %eax
	cmpb	(%rsi), %al
	jne	.G00_no
	cmpb	$0, %al
	je	.G01_si
	incq	%rdi
	incq	%rsi
	jmp	.G00_loop
.G00_no:
	movl	$0, %eax
	ret
.G01_si:
	movl	$1, %eax
	ret
