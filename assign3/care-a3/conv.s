# %edi  = signal[]
# %esi  = h[]
# %edx  = length of arrs
# %eax  = sum
# %ecx 	= loop counter
# %r8d  = h counter
# %r9d 	= temp sum
# %r10d = negation of ecx

	.globl conv
conv:
	movl $0, %eax
	movl $0, %ecx
	leal (%esi, %edx, 8), %r8d	# r8d = adress of h[n-1]

loop:	cmpl %ecx, %edx
	je end

	movl %ecx, %r10d		# negate ecx for backwards loop
	neg %r10d

	movl (%edi, %ecx, 8), %r9d	# r9d = signal[m]
	imull (%r8d, %r10d, 8), %r9d	# r9d *= h[n-1-m]
	addl %r9d, %eax			# eax = r9d

	incl %ecx
	jmp loop
end:	
	ret
