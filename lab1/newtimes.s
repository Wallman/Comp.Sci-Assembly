
	.globl _times
_times:	mov $0, %eax
	leal (%eax, %edi, 4), %eax
	leal (%eax, 4), %eax
	ret
