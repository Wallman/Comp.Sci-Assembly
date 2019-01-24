# eax = result
# edi = x
# esi = kth bit
# edx = squared-test
# ecx = counter

	.globl sqrt
sqrt:
	movl $0, %eax
	movl $15, %ecx
loop:
	cmpl $0, %ecx  
	jl end

	movl $1, %esi		# set kth bit to 1
	shll %cl, %esi
	orl %esi, %eax

	mov %eax, %edx		# if x*x > x set kth bit to 0
	imull %edx, %edx
	cmpl %edx, %edi
	jl undo			# else iterate again
	decl %ecx
	jmp loop
undo:
	xorl %esi, %eax		# set kth bit to 0
	decl %ecx
	jmp loop
end:	
	ret
