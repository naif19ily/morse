#  _____ ___ ___ ___ ___ 
# |     | . |  _|_ -| -_|
# |_|_|_|___|_| |___|___|
#
# Jun 11 2025
#

.section .bss
	__buffer: .zero 4096
	.globl __buffer

.section .rodata
	__t2mspace: .string "/ "
	.globl __t2mspace

	__unknown: .string "<?> "
	.globl __unknown

	__abc: .string "abcdefghijklmnopqrstuvwxyz\n /"
	.globl __abc

	.ma: .string ".- "
	.mb: .string "-... "
	.mc: .string "-.-. "
	.md: .string "-.. "
	.me: .string ". "
	.mf: .string "..-. "
	.mg: .string "--. "
	.mh: .string ".... "
	.mi: .string ".. "
	.mj: .string ".--- "
	.mk: .string "-.- "
	.ml: .string ".-.. "
	.mm: .string "-- "
	.mn: .string "-. "
	.mo: .string "--- "
	.mp: .string ".--. "
	.mq: .string "--.- "
	.mr: .string ".-. "

	.ms: .string "... "
	.mt: .string "- "
	.mu: .string "..- "
	.mv: .string "...- "
	.mw: .string ".-- "
	.mx: .string "-..- "
	.my: .string "-.-- "
	.mz: .string "--.. "
	.m0: .string "----- "
	.m1: .string ".---- "
	.m2: .string "..--- "
	.m3: .string "...-- "
	.m4: .string "....- "
	.m5: .string "..... "
	.m6: .string "-.... "
	.m7: .string "--... "
	.m8: .string "---.. "
	.m9: .string "----. "

	__morse:
		.quad .ma
		.quad .mb
		.quad .mc
		.quad .md
		.quad .me
		.quad .mf
		.quad .mg
		.quad .mh
		.quad .mi
		.quad .mj
		.quad .mk
		.quad .ml
		.quad .mm
		.quad .mn
		.quad .mo
		.quad .mp
		.quad .mq
		.quad .mr
		.quad .ms
		.quad .mt
		.quad .mu
		.quad .mv
		.quad .mw
		.quad .mx
		.quad .my
		.quad .mz
		.quad .m0
		.quad .m1
		.quad .m2
		.quad .m3
		.quad .m4
		.quad .m5
		.quad .m6
		.quad .m7
		.quad .m8
		.quad .m9
	.globl __morse
