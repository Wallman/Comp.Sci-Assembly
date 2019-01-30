# %edi = signal[]
# %esi = h[]
# %edx = length of arrs
# %eax = sum
# %ecx = loop counter
# %r8d = h counter
# %r9d = temp

	.globl _conv
_conv:
	movl $0, %eax
	movl $0, %ecx
	leal (%esi, %edi, 8), %r8d

loop:	cmpl %ecx, %edx
	je end

	movl %ecx, %r10d		#negate ecx for backwards loop
	neg %r10d

	movl (%edx, %ecx, 8), %r9d
	imull (%r8d, %r10d, 8), %r9d
	addl %r9d, %eax
	incl %ecx
	jmp loop
end:	
	ret
