	.globl sum_float

	# var map:
	#   %xmm0:  total
	#   %rdi:   F[n] (base pointer), head(F)
	#   %rsi:   n
	#   %rbp:   endptr, tail{F}
	#	%rsp:	tail{Q}
	#	%rbx:	head{Q}
	#	%xmm8 	x
	#	%xmm9	y

	#	+INF = 0x7f800000

sum_float:
	push	%rbp
	push	%rbx
	pushq	%r10
	movq	%rsp, %r10

	xorps	%xmm0, %xmm0            # total <- 0.0
	leaq	(%rdi, %rsi, 4), %rbp   # endptr <- F + n
	pushq	(%rdi)					# enqueue(head(F))
	add 	$4, %rdi				# increase head(F)
	movq	%rsp, %rbx	# set rbx
loop:
	cmpq	%rdi, %rbp             
	jle		endloop                 # while (head(F) < endptr) {

	movq	(%rdi), %xmm8			# xmm8 = head(F)
	ucomiss (%rbx), %xmm8			# head(Q) - head(F)
	jb 		dequeueQ
	add 	$4, %rdi				# increase head(F)
	jmp		cont

dequeueQ:
	movq	(%rbx), %xmm8			# xmm8 = head(Q)
	sub 	$8, %rbx				# dequeue Q
cont:
	movq	(%rdi), %xmm9			# xmm8 = head(F)
	ucomiss (%rbx), %xmm9			# head(Q) - head(F)
	jb 		dequeueQ2
	add 	$4, %rdi				# increase head(F)
	jmp		cont2

dequeueQ2:
	movq	(%rbx), %xmm9			# xmm8 = head(Q)
	sub 	$8, %rbx				# dequeue Q
cont2:
	movss	%xmm8, %xmm10			# xmm10 = x
	addss	%xmm9, %xmm10 			# xmm10 +=y
	sub		$8, %rsp				# pushq xmm10 manually
	movq	%xmm10, (%rsp)
	add 	$8, %rbx				# increase head(Q)

	jmp		loop                    # }

endloop:
	movq	%rbx, %rax			 	# result = head(Q)
	movq	%r10, %rsp
	pop		%r10
	pop 	%rbx
	pop		%rbp
	ret
