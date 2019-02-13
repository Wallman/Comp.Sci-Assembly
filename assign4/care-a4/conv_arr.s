
	.globl conv_arr
conv_arr:
	movl %esi, %r10d
	addl %ecx, %r10d
	subl $1, %r10d

loop:
	cmpl $0, %r10d
	jle end

	pushq %r8			# save variables *result, *x, *h
	pushq %rdi
	pushq %rdx
	pushq %rsi			# save variables n, m, counter
	pushq %rcx
	pushq %r10
	movl %r10d, %edi	# prepare arg1
	addl $1, %edi
	movl %ecx, %esi		# prepare arg2
	call min
	movl %eax, %r11d		# r11d = min(i+1, m)
	popq %r10			# restore variables n, m, counter
	popq %rcx
	popq %rsi

	pushq %rsi			# save variables n, m, counter, ladj
	pushq %rcx
	pushq %r10
	pushq %r11
	movl %r10d, %eax	# temp = i+1
	addl $1, %eax
	movl %ecx, %edi		# prepare args
	addl %esi, %edi
	subl %eax, %edi
	movl %ecx, %esi
	call min			# call min
	popq %r11			# restore variables m, counter, ladj
	popq %r10
	popq %rcx
	negl %eax			# eax = -eax
	addl %ecx, %eax		# eax = eax + m
	movl %eax, %r9d		# radj = eax
	popq %rsi			# restore variables n, *h, *x
	popq %rdx
	popq %rdi
	
	pushq %rsi			# save variables n, *x, *h, m, counter
	pushq %rdi
	pushq %rdx
	pushq %rcx
	pushq %r10
	movl %r10d, %eax 	# prepare arg1
	addl $1, %eax
	subl %r11d, %eax
	addl %eax, %edi
	movl %edx, %esi		# prepare arg2
	addl %r9d, %esi
	movl %r11d, %edx	# prepare arg3
	subl %r9d, %edx
	call conv 			# call conv
	popq %r10			# restore variables counter, m, *h, *x, n, *result
	popq %rcx
	popq %rdx
	popq %rdi
	popq %rsi
	popq %r8
	movl %eax, (%r8d, %r10d, 1)	# set result[i]

	decl %r10d
	jmp loop

end:
	ret

# void conv_arr(char *x, int n, char *h, int m, char *result){
#				   %rdi   %rsi   %rdx     %rcx    %r8
# %r10 = 	counter (caller saved)
# %r11 = 	ladj (caller)
# %r9 =		radj (caller)
# %rax = 	temp (caller)


# 	for(int i=0; i<(n+m-1); i++){
# 		int ladj = min(i+1, m);
# 		int radj = m - min(m+n-(i+1), m);
# 		result[i] = conv(x + (i+1-ladj), h + radj, ladj-radj);
# 	}

# }
