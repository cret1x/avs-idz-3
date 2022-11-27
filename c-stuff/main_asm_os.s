	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	fact
	.type	fact, @function
fact:
	mov	eax, 1
.L2:
	test	rdi, rdi
	jle	.L5
	imul	rax, rdi
	dec	rdi
	jmp	.L2
.L5:
	ret
	.size	fact, .-fact
	.globl	do_task
	.type	do_task, @function
do_task:
	push	rbx
	xorps	xmm2, xmm2
	movapd	xmm3, xmm0
	xor	ebx, ebx
	sub	rsp, 16
.L7:
	cvtsi2sd	xmm1, ebx
	movapd	xmm0, xmm3
	movsd	QWORD PTR 8[rsp], xmm2
	movsd	QWORD PTR [rsp], xmm3
	call	pow@PLT
	mov	rdi, rbx
	add	rbx, 2
	call	fact
	cvtsi2sd	xmm1, rax
	cmp	rbx, 20
	movsd	xmm2, QWORD PTR 8[rsp]
	movsd	xmm3, QWORD PTR [rsp]
	divsd	xmm0, xmm1
	addsd	xmm2, xmm0
	jne	.L7
	add	rsp, 16
	movapd	xmm0, xmm2
	pop	rbx
	ret
	.size	do_task, .-do_task
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%lf"
	.text
	.globl	read_double_from_file
	.type	read_double_from_file, @function
read_double_from_file:
	sub	rsp, 24
	lea	rsi, .LC1[rip]
	xor	eax, eax
	lea	rdx, 8[rsp]
	call	__isoc99_fscanf@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 24
	ret
	.size	read_double_from_file, .-read_double_from_file
	.globl	get_rand_value
	.type	get_rand_value, @function
get_rand_value:
	push	rbx
	mov	rbx, rdi
	sub	rsp, 16
	mov	QWORD PTR 8[rsp], rsi
	call	rand@PLT
	mov	rsi, QWORD PTR 8[rsp]
	cdqe
	add	rsp, 16
	cqo
	sub	rsi, rbx
	idiv	rsi
	lea	rax, [rdx+rbx]
	pop	rbx
	ret
	.size	get_rand_value, .-get_rand_value
	.section	.rodata.str1.1
.LC2:
	.string	"Invalid args count"
.LC3:
	.string	"-f"
.LC4:
	.string	"r"
.LC5:
	.string	"w"
.LC6:
	.string	"Error opening the files"
.LC7:
	.string	"%f\n"
.LC8:
	.string	"Elapsed time:"
.LC10:
	.string	"Read:\t\t%f\n"
.LC11:
	.string	"Calculations:\t%f\n"
.LC12:
	.string	"Write:\t\t%f\n"
.LC13:
	.string	"-r"
.LC14:
	.string	"Generated x value: %f\n"
.LC15:
	.string	"Value of ch(x): %f\n"
.LC16:
	.string	"Invalid flag"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	ebp, edi
	xor	edi, edi
	mov	rbx, rsi
	sub	rsp, 24
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	ebp, 1
	jg	.L15
.L18:
	lea	rdi, .LC2[rip]
	jmp	.L27
.L15:
	mov	r12, QWORD PTR 8[rbx]
	lea	rsi, .LC3[rip]
	mov	rdi, r12
	call	strcmp@PLT
	test	eax, eax
	jne	.L17
	cmp	ebp, 4
	jne	.L18
	mov	rdi, QWORD PTR 16[rbx]
	lea	rsi, .LC4[rip]
	call	fopen@PLT
	mov	rdi, QWORD PTR 24[rbx]
	lea	rsi, .LC5[rip]
	mov	r13, rax
	call	fopen@PLT
	test	r13, r13
	mov	r14, rax
	je	.L23
	test	rax, rax
	jne	.L19
.L23:
	lea	rdi, .LC6[rip]
	jmp	.L27
.L19:
	call	clock@PLT
	mov	rdi, r13
	mov	rbx, rax
	call	read_double_from_file
	movsd	QWORD PTR [rsp], xmm0
	call	clock@PLT
	sub	rax, rbx
	mov	ebx, 10000000
	mov	r12, rax
	call	clock@PLT
	mov	r15, rax
.L21:
	movsd	xmm0, QWORD PTR [rsp]
	call	do_task
	dec	ebx
	jne	.L21
	movsd	QWORD PTR [rsp], xmm0
	call	clock@PLT
	sub	rax, r15
	mov	rbp, rax
	call	clock@PLT
	lea	rdx, .LC7[rip]
	movsd	xmm0, QWORD PTR [rsp]
	mov	esi, 1
	mov	rbx, rax
	mov	rdi, r14
	mov	al, 1
	call	__fprintf_chk@PLT
	call	clock@PLT
	mov	rdi, r13
	sub	rax, rbx
	mov	rbx, rax
	call	fclose@PLT
	mov	rdi, r14
	call	fclose@PLT
	lea	rdi, .LC8[rip]
	call	puts@PLT
	cvtsi2sd	xmm0, r12
	lea	rsi, .LC10[rip]
	mov	edi, 1
	mov	al, 1
	divsd	xmm0, QWORD PTR .LC9[rip]
	call	__printf_chk@PLT
	cvtsi2sd	xmm0, rbp
	lea	rsi, .LC11[rip]
	mov	edi, 1
	mov	al, 1
	divsd	xmm0, QWORD PTR .LC9[rip]
	call	__printf_chk@PLT
	cvtsi2sd	xmm0, rbx
	lea	rsi, .LC12[rip]
	divsd	xmm0, QWORD PTR .LC9[rip]
	jmp	.L26
.L17:
	lea	rsi, .LC13[rip]
	mov	rdi, r12
	call	strcmp@PLT
	test	eax, eax
	jne	.L22
	cmp	ebp, 4
	jne	.L18
	mov	rdi, QWORD PTR 16[rbx]
	call	atol@PLT
	mov	rdi, QWORD PTR 24[rbx]
	mov	rbp, rax
	call	atol@PLT
	mov	rdi, rbp
	mov	rsi, rax
	call	get_rand_value
	cvtsi2sd	xmm1, rax
	movapd	xmm0, xmm1
	movsd	QWORD PTR 8[rsp], xmm1
	call	do_task
	movsd	xmm1, QWORD PTR 8[rsp]
	lea	rsi, .LC14[rip]
	movsd	QWORD PTR [rsp], xmm0
	mov	edi, 1
	mov	al, 1
	movapd	xmm0, xmm1
	call	__printf_chk@PLT
	movsd	xmm2, QWORD PTR [rsp]
	lea	rsi, .LC15[rip]
	movapd	xmm0, xmm2
.L26:
	mov	edi, 1
	mov	al, 1
	call	__printf_chk@PLT
	jmp	.L16
.L22:
	lea	rdi, .LC16[rip]
.L27:
	call	puts@PLT
.L16:
	add	rsp, 24
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC9:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
