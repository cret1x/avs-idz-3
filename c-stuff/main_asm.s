	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	fact
	.type	fact, @function
fact:
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -8[rbp], 1
	jmp	.L2
.L3:
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -8[rbp], rax
	sub	QWORD PTR -24[rbp], 1
.L2:
	cmp	QWORD PTR -24[rbp], 0
	jg	.L3
	mov	rax, QWORD PTR -8[rbp]
	pop	rbp
	ret
	.size	fact, .-fact
	.globl	do_task
	.type	do_task, @function
do_task:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	movsd	QWORD PTR -40[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0
	mov	DWORD PTR -12[rbp], 0
	jmp	.L6
.L7:
	cvtsi2sd	xmm0, DWORD PTR -12[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm1, xmm0
	mov	QWORD PTR -48[rbp], rax
	movsd	xmm0, QWORD PTR -48[rbp]
	call	pow@PLT
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	mov	rdi, rax
	call	fact
	mov	QWORD PTR -32[rbp], rax
	cvtsi2sd	xmm0, QWORD PTR -32[rbp]
	movsd	xmm1, QWORD PTR -24[rbp]
	divsd	xmm1, xmm0
	movapd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -8[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	add	DWORD PTR -12[rbp], 2
.L6:
	cmp	DWORD PTR -12[rbp], 19
	jle	.L7
	movsd	xmm0, QWORD PTR -8[rbp]
	leave
	ret
	.size	do_task, .-do_task
	.section	.rodata
.LC1:
	.string	"%lf"
	.text
	.globl	read_double_from_file
	.type	read_double_from_file, @function
read_double_from_file:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	lea	rdx, -8[rbp]
	mov	rax, QWORD PTR -24[rbp]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	movsd	xmm0, QWORD PTR -8[rbp]
	leave
	ret
	.size	read_double_from_file, .-read_double_from_file
	.globl	get_rand_value
	.type	get_rand_value, @function
get_rand_value:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi
	mov	QWORD PTR -16[rbp], rsi
	call	rand@PLT
	cdqe
	mov	rdx, QWORD PTR -16[rbp]
	mov	rcx, rdx
	sub	rcx, QWORD PTR -8[rbp]
	cqo
	idiv	rcx
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	leave
	ret
	.size	get_rand_value, .-get_rand_value
	.section	.rodata
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
.LC9:
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
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 176
	mov	DWORD PTR -148[rbp], edi
	mov	QWORD PTR -160[rbp], rsi
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	cmp	DWORD PTR -148[rbp], 1
	jg	.L14
	lea	rdi, .LC2[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L15
.L14:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L16
	cmp	DWORD PTR -148[rbp], 4
	je	.L17
	lea	rdi, .LC2[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L15
.L17:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -64[rbp], rax
	cmp	QWORD PTR -56[rbp], 0
	je	.L18
	cmp	QWORD PTR -64[rbp], 0
	jne	.L19
.L18:
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L15
.L19:
	call	clock@PLT
	mov	QWORD PTR -72[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	read_double_from_file
	movq	rax, xmm0
	mov	QWORD PTR -80[rbp], rax
	call	clock@PLT
	sub	rax, QWORD PTR -72[rbp]
	mov	QWORD PTR -88[rbp], rax
	call	clock@PLT
	mov	QWORD PTR -96[rbp], rax
	mov	DWORD PTR -12[rbp], 0
	jmp	.L20
.L21:
	mov	rax, QWORD PTR -80[rbp]
	mov	QWORD PTR -168[rbp], rax
	movsd	xmm0, QWORD PTR -168[rbp]
	call	do_task
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	add	DWORD PTR -12[rbp], 1
.L20:
	cmp	DWORD PTR -12[rbp], 9999999
	jle	.L21
	call	clock@PLT
	sub	rax, QWORD PTR -96[rbp]
	mov	QWORD PTR -104[rbp], rax
	call	clock@PLT
	mov	QWORD PTR -112[rbp], rax
	mov	rdx, QWORD PTR -8[rbp]
	mov	rax, QWORD PTR -64[rbp]
	mov	QWORD PTR -168[rbp], rdx
	movsd	xmm0, QWORD PTR -168[rbp]
	lea	rsi, .LC7[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	call	clock@PLT
	sub	rax, QWORD PTR -112[rbp]
	mov	QWORD PTR -120[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	fclose@PLT
	cvtsi2sd	xmm0, QWORD PTR -88[rbp]
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -128[rbp], xmm0
	cvtsi2sd	xmm0, QWORD PTR -104[rbp]
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -136[rbp], xmm0
	cvtsi2sd	xmm0, QWORD PTR -120[rbp]
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -144[rbp], xmm0
	lea	rdi, .LC9[rip]
	call	puts@PLT
	mov	rax, QWORD PTR -128[rbp]
	mov	QWORD PTR -168[rbp], rax
	movsd	xmm0, QWORD PTR -168[rbp]
	lea	rdi, .LC10[rip]
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -136[rbp]
	mov	QWORD PTR -168[rbp], rax
	movsd	xmm0, QWORD PTR -168[rbp]
	lea	rdi, .LC11[rip]
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -144[rbp]
	mov	QWORD PTR -168[rbp], rax
	movsd	xmm0, QWORD PTR -168[rbp]
	lea	rdi, .LC12[rip]
	mov	eax, 1
	call	printf@PLT
	jmp	.L22
.L16:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC13[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L23
	cmp	DWORD PTR -148[rbp], 4
	je	.L24
	lea	rdi, .LC2[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L15
.L24:
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atol@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -160[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atol@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	rdx, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	get_rand_value
	cvtsi2sd	xmm0, rax
	movsd	QWORD PTR -40[rbp], xmm0
	mov	rax, QWORD PTR -40[rbp]
	mov	QWORD PTR -168[rbp], rax
	movsd	xmm0, QWORD PTR -168[rbp]
	call	do_task
	movq	rax, xmm0
	mov	QWORD PTR -48[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	mov	QWORD PTR -168[rbp], rax
	movsd	xmm0, QWORD PTR -168[rbp]
	lea	rdi, .LC14[rip]
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -168[rbp], rax
	movsd	xmm0, QWORD PTR -168[rbp]
	lea	rdi, .LC15[rip]
	mov	eax, 1
	call	printf@PLT
	jmp	.L22
.L23:
	lea	rdi, .LC16[rip]
	call	puts@PLT
.L22:
	mov	eax, 0
.L15:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC8:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
