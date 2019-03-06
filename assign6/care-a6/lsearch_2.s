	# Variable map
	# %rdi	first arg
	# %esi	second arg (string?)
	# %r9d	
	# %edx	
	# %ecx	
	# %r8d	
	# %rax	result


	.globl	lsearch_2
lsearch_2:
	testl	%esi, %esi			# if esi <= 0 goto error
	jle	error
	movslq	%esi, %rax			# move string? rax <- esi
	leaq	-4(%rdi,%rax,4), %rax
	movl	(%rax), %r9d
	movl	%edx, (%rax)
	cmpl	(%rdi), %edx
	je	.L7
	movl	$1, %ecx
.L5:
	movl	%ecx, %r8d
	addq	$1, %rcx
	cmpl	%edx, -4(%rdi,%rcx,4)
	jne	.L5
.L4:
	movl	%r9d, (%rax)
	leal	-1(%rsi), %eax
	cmpl	%r8d, %eax
	jg	.L8
	cmpl	%edx, %r9d
	jne	.L6
	rep ret
.L8:
	movl	%r8d, %eax
	ret
.L7:
	xorl	%r8d, %r8d
	jmp	.L4
error:
	movl	$-1, %eax
	ret
