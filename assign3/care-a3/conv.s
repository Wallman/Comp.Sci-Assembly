# %rdi = signal[]
# %rsi = h[]
# %edx = length of arrs
# %eax = sum
# %ecx = counter

	.globl _conv
_conv:
	movl $0, %eax
	movl $0, %ecx

loop:	cmpl %ecx, %edx
	jle end
	leaq (%rsi,
	imul (%rdi, %ecx, 8), (%rsi,

end:	
	ret
