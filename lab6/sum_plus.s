	.globl sum_plus
sum_plus:
	xorl	%eax, %eax			# sum = 0
	testl	%esi, %esi			# if n = 0 return
	jle	done
	xorl	%edx, %edx			# edx = 0
	shl     $2, %rsi			# n = n*2*2
	xorl	%r8d, %r8d			# r8d = 0
loop:
	movl	(%rdi,%rdx), %ecx	# counter = basePtr*rdx
	testl	%ecx, %ecx
	cmovle	%r8d, %ecx
	addl	%ecx, %eax
endif:
	addq	$4, %rdx
	cmpq	%rsi, %rdx
	jne	loop
done:
	ret
