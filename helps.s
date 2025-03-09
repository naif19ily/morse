#                __
#               / _)
#      _.----._/ /	dc0x13
#     /         /	part of `morse` project.
#  __/ (  | (  |	Mar 09 2025
# /__.-'|_|--|_|

.globl	FX_MORSEABLE


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

# Tells if the current character (%rdi) can be turn
# into a morse representation.
FX_MORSEABLE:
	call	FX_IS_LOWER
	cmpl	$1, %eax
	je	.D00_return
	call	FX_IS_UPPER
	cmpl	$1, %eax
	je	.D00_return
	call	FX_IS_DIGIT
	cmpl	$1, %eax
	je	.D00_return
.D00_return:
	ret
