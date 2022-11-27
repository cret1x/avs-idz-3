	.file	"main.c"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.globl	fact
	.type	fact, @function
fact:
	test	rdi, rdi
	jle	.L7
	lea	rcx, -1[rdi]
	mov	rsi, rdi
	cmp	rcx, 13
	jle	.L8
	mov	QWORD PTR -16[rsp], rdi
	mov	rdx, rdi
	xor	eax, eax
	movq	xmm1, QWORD PTR -16[rsp]
	mov	QWORD PTR -16[rsp], rcx
	movhps	xmm1, QWORD PTR -16[rsp]
	movdqa	xmm0, XMMWORD PTR .LC0[rip]
	shr	rdx
	movdqa	xmm5, XMMWORD PTR .LC1[rip]
	.p2align 4,,10
	.p2align 3
.L4:
	movdqa	xmm3, xmm1
	movdqa	xmm4, xmm1
	movdqa	xmm2, xmm0
	add	rax, 1
	cmp	rax, rdx
	pmuludq	xmm3, xmm0
	psrlq	xmm4, 32
	psrlq	xmm2, 32
	pmuludq	xmm0, xmm4
	pmuludq	xmm2, xmm1
	paddq	xmm1, xmm5
	paddq	xmm0, xmm2
	psllq	xmm0, 32
	paddq	xmm0, xmm3
	jb	.L4
	movdqa	xmm4, xmm0
	mov	rdx, rdi
	movdqa	xmm2, xmm0
	movdqa	xmm1, xmm0
	psrldq	xmm4, 8
	and	rdx, -2
	movdqa	xmm3, xmm4
	sub	rdi, rdx
	cmp	rsi, rdx
	pmuludq	xmm2, xmm4
	psrlq	xmm1, 32
	psrlq	xmm3, 32
	pmuludq	xmm1, xmm4
	pmuludq	xmm0, xmm3
	paddq	xmm1, xmm0
	psllq	xmm1, 32
	paddq	xmm1, xmm2
	movq	rax, xmm1
	je	.L1
	lea	rcx, -1[rdi]
.L3:
	imul	rax, rdi
	test	rcx, rcx
	je	.L1
	mov	rdx, rdi
	imul	rax, rcx
	sub	rdx, 2
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 3
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 4
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 5
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 6
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 7
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 8
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 9
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 10
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 11
	je	.L1
	imul	rax, rdx
	mov	rdx, rdi
	sub	rdx, 12
	je	.L1
	imul	rax, rdx
	sub	rdi, 13
	je	.L1
	imul	rax, rdi
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	mov	eax, 1
.L1:
	rep ret
	.p2align 4,,10
	.p2align 3
.L8:
	mov	eax, 1
	jmp	.L3
	.size	fact, .-fact
	.p2align 4,,15
	.globl	do_task
	.type	do_task, @function
do_task:
	push	rbx
	pxor	xmm7, xmm7
	xor	ebx, ebx
	sub	rsp, 32
	movsd	QWORD PTR 24[rsp], xmm0
	movdqa	xmm6, XMMWORD PTR .LC1[rip]
	.p2align 4,,10
	.p2align 3
.L51:
	pxor	xmm1, xmm1
	movaps	XMMWORD PTR [rsp], xmm6
	movsd	QWORD PTR 16[rsp], xmm7
	cvtsi2sd	xmm1, ebx
	call	__pow_finite@PLT
	test	rbx, rbx
	movsd	xmm7, QWORD PTR 16[rsp]
	movdqa	xmm6, XMMWORD PTR [rsp]
	je	.L52
	lea	rax, -1[rbx]
	mov	QWORD PTR 16[rsp], rbx
	mov	rdx, rbx
	movq	xmm2, QWORD PTR 16[rsp]
	shr	rdx
	mov	QWORD PTR 16[rsp], rax
	xor	eax, eax
	movhps	xmm2, QWORD PTR 16[rsp]
	movdqa	xmm3, XMMWORD PTR .LC0[rip]
	.p2align 4,,10
	.p2align 3
.L53:
	movdqa	xmm5, xmm3
	add	rax, 1
	movdqa	xmm1, xmm3
	cmp	rax, rdx
	movdqa	xmm4, xmm2
	pmuludq	xmm5, xmm2
	psrlq	xmm1, 32
	pmuludq	xmm1, xmm2
	paddq	xmm2, xmm6
	psrlq	xmm4, 32
	pmuludq	xmm3, xmm4
	paddq	xmm1, xmm3
	psllq	xmm1, 32
	paddq	xmm5, xmm1
	movdqa	xmm3, xmm5
	jb	.L53
	psrldq	xmm5, 8
	movdqa	xmm4, xmm3
	movdqa	xmm1, xmm5
	movdqa	xmm2, xmm5
	cmp	ebx, 18
	pmuludq	xmm1, xmm3
	psrlq	xmm4, 32
	psrlq	xmm2, 32
	pmuludq	xmm3, xmm2
	movdqa	xmm2, xmm4
	pmuludq	xmm2, xmm5
	paddq	xmm3, xmm2
	psllq	xmm3, 32
	paddq	xmm3, xmm1
	pxor	xmm1, xmm1
	movq	rax, xmm3
	cvtsi2sdq	xmm1, rax
	divsd	xmm0, xmm1
	addsd	xmm7, xmm0
	je	.L58
.L54:
	add	rbx, 2
	movsd	xmm0, QWORD PTR 24[rsp]
	jmp	.L51
	.p2align 4,,10
	.p2align 3
.L52:
	addsd	xmm7, xmm0
	jmp	.L54
	.p2align 4,,10
	.p2align 3
.L58:
	add	rsp, 32
	movapd	xmm0, xmm7
	pop	rbx
	ret
	.size	do_task, .-do_task
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"%lf"
	.text
	.p2align 4,,15
	.globl	read_double_from_file
	.type	read_double_from_file, @function
read_double_from_file:
	sub	rsp, 24
	lea	rsi, .LC3[rip]
	xor	eax, eax
	lea	rdx, 8[rsp]
	call	__isoc99_fscanf@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	add	rsp, 24
	ret
	.size	read_double_from_file, .-read_double_from_file
	.p2align 4,,15
	.globl	get_rand_value
	.type	get_rand_value, @function
get_rand_value:
	push	rbp
	push	rbx
	mov	rbp, rdi
	mov	rbx, rsi
	sub	rsp, 8
	sub	rbx, rbp
	call	rand@PLT
	cdqe
	add	rsp, 8
	cqo
	idiv	rbx
	pop	rbx
	lea	rax, [rdx+rbp]
	pop	rbp
	ret
	.size	get_rand_value, .-get_rand_value
	.section	.rodata.str1.1
.LC4:
	.string	"Invalid args count"
.LC5:
	.string	"-f"
.LC6:
	.string	"r"
.LC7:
	.string	"w"
.LC8:
	.string	"Error opening the files"
.LC9:
	.string	"%f\n"
.LC10:
	.string	"Elapsed time:"
.LC12:
	.string	"Read:\t\t%f\n"
.LC13:
	.string	"Calculations:\t%f\n"
.LC14:
	.string	"Write:\t\t%f\n"
.LC15:
	.string	"-r"
.LC16:
	.string	"Generated x value: %f\n"
.LC17:
	.string	"Value of ch(x): %f\n"
.LC18:
	.string	"Invalid flag"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
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
	sub	rsp, 56
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	ebp, 1
	jle	.L67
	mov	rdx, QWORD PTR 8[rbx]
	lea	rdi, .LC5[rip]
	mov	ecx, 3
	mov	rsi, rdx
	repz cmpsb
	seta	al
	sbb	al, 0
	test	al, al
	jne	.L66
	cmp	ebp, 4
	jne	.L67
	mov	rdi, QWORD PTR 16[rbx]
	lea	rsi, .LC6[rip]
	call	fopen@PLT
	mov	rdi, QWORD PTR 24[rbx]
	lea	rsi, .LC7[rip]
	mov	r13, rax
	call	fopen@PLT
	test	r13, r13
	mov	r12, rax
	je	.L77
	test	rax, rax
	je	.L77
	call	clock@PLT
	lea	rdx, 40[rsp]
	lea	rsi, .LC3[rip]
	mov	rbx, rax
	mov	rdi, r13
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	movsd	xmm7, QWORD PTR 40[rsp]
	movsd	QWORD PTR 24[rsp], xmm7
	call	clock@PLT
	sub	rax, rbx
	mov	ebx, 10000000
	mov	rbp, rax
	call	clock@PLT
	movdqa	xmm6, XMMWORD PTR .LC1[rip]
	mov	r14, rax
	.p2align 4,,10
	.p2align 3
.L70:
	xor	r15d, r15d
	mov	QWORD PTR 16[rsp], 0x000000000
	.p2align 4,,10
	.p2align 3
.L75:
	pxor	xmm1, xmm1
	movsd	xmm0, QWORD PTR 24[rsp]
	movaps	XMMWORD PTR [rsp], xmm6
	cvtsi2sd	xmm1, r15d
	call	__pow_finite@PLT
	test	r15, r15
	movdqa	xmm6, XMMWORD PTR [rsp]
	je	.L71
	lea	rax, -1[r15]
	mov	QWORD PTR [rsp], r15
	mov	rdx, r15
	movq	xmm2, QWORD PTR [rsp]
	shr	rdx
	mov	QWORD PTR [rsp], rax
	xor	eax, eax
	movhps	xmm2, QWORD PTR [rsp]
	movdqa	xmm3, XMMWORD PTR .LC0[rip]
	.p2align 4,,10
	.p2align 3
.L72:
	movdqa	xmm5, xmm3
	add	rax, 1
	movdqa	xmm1, xmm3
	cmp	rdx, rax
	movdqa	xmm4, xmm2
	pmuludq	xmm5, xmm2
	psrlq	xmm1, 32
	pmuludq	xmm1, xmm2
	paddq	xmm2, xmm6
	psrlq	xmm4, 32
	pmuludq	xmm3, xmm4
	paddq	xmm1, xmm3
	psllq	xmm1, 32
	paddq	xmm5, xmm1
	movdqa	xmm3, xmm5
	ja	.L72
	psrldq	xmm5, 8
	movdqa	xmm4, xmm3
	movdqa	xmm1, xmm5
	movdqa	xmm2, xmm5
	cmp	r15d, 18
	pmuludq	xmm1, xmm3
	psrlq	xmm4, 32
	psrlq	xmm2, 32
	pmuludq	xmm3, xmm2
	movdqa	xmm2, xmm4
	pmuludq	xmm2, xmm5
	paddq	xmm3, xmm2
	psllq	xmm3, 32
	paddq	xmm3, xmm1
	pxor	xmm1, xmm1
	movq	rax, xmm3
	cvtsi2sdq	xmm1, rax
	divsd	xmm0, xmm1
	addsd	xmm0, QWORD PTR 16[rsp]
	movsd	QWORD PTR 16[rsp], xmm0
	je	.L81
.L73:
	add	r15, 2
	jmp	.L75
.L66:
	lea	rsi, .LC15[rip]
	mov	rdi, rdx
	call	strcmp@PLT
	test	eax, eax
	jne	.L76
	cmp	ebp, 4
	je	.L82
.L67:
	lea	rdi, .LC4[rip]
	call	puts@PLT
.L79:
	add	rsp, 56
	xor	eax, eax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L82:
	mov	rdi, QWORD PTR 16[rbx]
	xor	esi, esi
	mov	edx, 10
	call	strtol@PLT
	mov	rdi, QWORD PTR 24[rbx]
	xor	esi, esi
	mov	edx, 10
	mov	rbp, rax
	call	strtol@PLT
	mov	rbx, rax
	call	rand@PLT
	mov	rcx, rbx
	cdqe
	sub	rcx, rbp
	cqo
	idiv	rcx
	pxor	xmm1, xmm1
	add	rdx, rbp
	cvtsi2sdq	xmm1, rdx
	movapd	xmm0, xmm1
	movsd	QWORD PTR [rsp], xmm1
	call	do_task
	movsd	xmm1, QWORD PTR [rsp]
	lea	rsi, .LC16[rip]
	movsd	QWORD PTR 16[rsp], xmm0
	mov	edi, 1
	mov	eax, 1
	movapd	xmm0, xmm1
	call	__printf_chk@PLT
	movsd	xmm2, QWORD PTR 16[rsp]
	lea	rsi, .LC17[rip]
	mov	edi, 1
	mov	eax, 1
	movapd	xmm0, xmm2
	call	__printf_chk@PLT
	jmp	.L79
.L77:
	lea	rdi, .LC8[rip]
	call	puts@PLT
	jmp	.L79
	.p2align 4,,10
	.p2align 3
.L71:
	addsd	xmm0, QWORD PTR 16[rsp]
	movsd	QWORD PTR 16[rsp], xmm0
	jmp	.L73
	.p2align 4,,10
	.p2align 3
.L81:
	sub	ebx, 1
	jne	.L70
	call	clock@PLT
	sub	rax, r14
	mov	r14, rax
	call	clock@PLT
	lea	rdx, .LC9[rip]
	movsd	xmm0, QWORD PTR 16[rsp]
	mov	esi, 1
	mov	rdi, r12
	mov	rbx, rax
	mov	eax, 1
	call	__fprintf_chk@PLT
	call	clock@PLT
	mov	rdi, r13
	sub	rax, rbx
	mov	rbx, rax
	call	fclose@PLT
	mov	rdi, r12
	call	fclose@PLT
	lea	rdi, .LC10[rip]
	call	puts@PLT
	pxor	xmm0, xmm0
	lea	rsi, .LC12[rip]
	mov	edi, 1
	mov	eax, 1
	cvtsi2sdq	xmm0, rbp
	mulsd	xmm0, QWORD PTR .LC11[rip]
	call	__printf_chk@PLT
	pxor	xmm0, xmm0
	lea	rsi, .LC13[rip]
	mov	edi, 1
	mov	eax, 1
	cvtsi2sdq	xmm0, r14
	mulsd	xmm0, QWORD PTR .LC11[rip]
	call	__printf_chk@PLT
	pxor	xmm0, xmm0
	lea	rsi, .LC14[rip]
	mov	edi, 1
	mov	eax, 1
	cvtsi2sdq	xmm0, rbx
	mulsd	xmm0, QWORD PTR .LC11[rip]
	call	__printf_chk@PLT
	jmp	.L79
.L76:
	lea	rdi, .LC18[rip]
	call	puts@PLT
	jmp	.L79
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	1
	.quad	1
	.align 16
.LC1:
	.quad	-2
	.quad	-2
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC11:
	.long	2696277389
	.long	1051772663
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
