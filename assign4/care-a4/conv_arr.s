# void conv_arr(char *x, int n, char *h, int m, char *result)
#				   %rdi   %rsi   %rdx     %rcx    %r8

# %r10 = 	i (caller saved)
# %r11 = 	ladj (caller)
# %r9 =		radj (caller)
# %rax = 	temp (caller)

# 	for(int i=0; i<(n+m-1); i++){
# 		int ladj = min(i+1, m);
# 		int radj = m - min(m+n-(i+1), m);
# 		result[i] = conv(x + (i+1-ladj), h + radj, ladj-radj);
# 	}

# Function returns the convolution of two signals in the result-array.
# Function uses the subroutines min and conv.

	.globl conv_arr
conv_arr:
	movl %esi, %r10d			# i = n
	addl %ecx, %r10d			# i = i + m
	subl $2, %r10d				# i = i - 2

loop:
	cmpl $0, %r10d
	jle end

	pushq %r8					# save variables *result, *x, *h
	pushq %rdi
	pushq %rdx
	pushq %rsi					# save variables n, m, i
	pushq %rcx
	pushq %r10
	movl %r10d, %edi			# rdi = i
	addl $1, %edi				# rdi+1
	movl %ecx, %esi				# rsi = m
	call min
	movl %eax, %r11d			# ladj = min(i+1, m)
	popq %r10					# restore variables n, m, i
	popq %rcx
	popq %rsi

	pushq %rsi					# save variables n, m, i, ladj
	pushq %rcx
	pushq %r10
	pushq %r11
	movl %r10d, %eax			# temp = i
	addl $1, %eax				# temp+1
	movl %ecx, %edi				# rdi = m
	addl %esi, %edi				# rdi = rdi-n
	subl %eax, %edi				# rdi = rdi-(i+1)
	movl %ecx, %esi				# rsi = m
	call min					# call min
	popq %r11					# restore variables m, i, ladj
	popq %r10
	popq %rcx
	negl %eax					# eax = -eax
	addl %ecx, %eax				# eax = eax + m
	movl %eax, %r9d				# radj = eax
	popq %rsi					# restore variables n, *h, *x
	popq %rdx
	popq %rdi
	
	pushq %rsi					# save variables n, *x, *h, m, i
	pushq %rdi
	pushq %rdx
	pushq %rcx
	pushq %r10
	movl %r10d, %eax 			# temp = i
	addl $1, %eax				# temp = temp+1
	subl %r11d, %eax			# temp = temp-ladj
	leaq (%rdi, %rax), %rdi 	# x = x + temp
	leaq (%rdx, %r9), %rsi		# h = h + radj
	movl %r11d, %edx			# edx = ladj
	subl %r9d, %edx				# edx = edx + radj
	call conv 					# call conv
	popq %r10					# restore variables i, m, *h, *x, n, *result
	popq %rcx
	popq %rdx
	popq %rdi
	popq %rsi
	popq %r8
	pushq %r8					# save %r8
	leaq (%r8, %r10), %r8		# %r8 = r8[i]
	movb %al, (%r8)				# result[i] = conv()
	popq %r8

	decl %r10d
	jmp loop

end:
	ret
