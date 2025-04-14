.section .rodata
	
	.usage_msg:	.string	"\n  morse-usage: morse [mode] [message]\n\n"
	.usage_len:	.long	40

	.globl		.usage_msg
	.globl		.usage_len
