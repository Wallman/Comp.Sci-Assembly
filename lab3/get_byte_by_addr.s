	.globl get_byte_by_addr
get_byte_by_addr:
	mov (%rdi, %rsi, 1), %al        # new solution
        ret

	movl $0, %eax			# old solution
	movl $0, %ecx
	movq (%rdi), %rdx

loop:		
	cmp %ecx, %esi
	jle end
	shr $8, %rdx
	dec %ecx
	jmp loop
end:
	movb %dl, %al
	ret
