	.globl _mystery
_mystery:
	movl	$0, %eax  # 0 -> result
	leaq	(%rdi, %rsi), %rcx  # (str) + n -> rcx

loop:
	cmpq	%rdi, %rcx  # counter - (str) ? 0
	jle	endl
	decq	%rcx
	cmpb	$0x6f, (%rcx)  # (counter) - 111 ? 0
	jne	loop
	incl	%eax
	jmp	loop

endl:
	ret
