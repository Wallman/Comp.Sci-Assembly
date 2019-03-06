	# Variable map
	# %rdi	int *A
	# %esi	int n
	# %edx	int target
	# %ecx	counter
	# %r8d	tmpCounter
	# %r9d	tmp
	# %rax	result


	.globl	lsearch_2
lsearch_2:
	testl	%esi, %esi				# if n <= return -1
	jle	error
	movslq	%esi, %rax
	leaq	-4(%rdi,%rax,4), %rax
	movl	(%rax), %r9d			# tmp = A[n-1]
	movl	%edx, (%rax)			# A[n-1] = target
	cmpl	(%rdi), %edx			# if A[0]==target goto izero
	je	izero
	movl	$1, %ecx				# counter = 1
loop:
	movl	%ecx, %r8d
	addq	$1, %rcx				# i++
	cmpl	%edx, -4(%rdi,%rcx,4)	# while(A[i] != target)
	jne	loop
conditionals:
	movl	%r9d, (%rax)			# A[n-1] = tmp
	leal	-1(%rsi), %eax
	cmpl	%r8d, %eax				# if i < n-1 return i
	jg	returni
	cmpl	%edx, %r9d				# if target != tmp return -1
	jne	error
	rep ret 						# return n-1
returni:
	movl	%r8d, %eax				# result = tmp_counter
	ret
izero:
	xorl	%r8d, %r8d				# tmp_counter = 0
	jmp	conditionals
error:
	movl	$-1, %eax				# return -1
	ret
