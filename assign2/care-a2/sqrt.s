# eax = result
# edi = x
# esi = kth bit
# edx = squared-test
# ecx = counter

	.globl _sqrt
_sqrt:
	movl $0, %eax
	movl $15, %ecx
loop:
	cmpl $0, %ecx  
	jl end

	movl $1, %esi			# esi = 1
	shll %cl, %esi			# 1 << (ecx times)
	andl %esi, %eax			# bitwise AND

	mov %eax, %edx
	shll $1, %edx			# edx = x*x
	cmpl %edx, %edi			# edi - edx
	jl undo				# if edx > edi jmp shift
	decl %ecx			# else iterate again
	jmp loop
undo:
	xorl %esi, %eax
	decl %ecx
	jmp loop
end:	
	ret
