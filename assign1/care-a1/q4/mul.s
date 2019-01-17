	.globl times
times:
	movl $0, %eax		# result = 0
	movl $0, %ecx		# counter = 0
loop:	
	cmpl %ecx, %esi		# compare b with counter
	jle end			# if B – counter <= 0 jump to end
	addl %edi, %eax		# else add A to result 
	incl %ecx		# increment counter
	jmp loop		# iterate loop again
end:
	ret

