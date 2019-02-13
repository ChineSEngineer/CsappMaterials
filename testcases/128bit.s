	.file	"128bit.c"
	.text
	.globl	store_uprod
	.type	store_uprod, @function
store_uprod:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %r8
	movl	$0, %r9d
	movq	-40(%rbp), %rax
	movq	%rax, %rcx
	movl	$0, %ebx
	movq	%r9, %rdx
	imulq	%rcx, %rdx
	movq	%rbx, %rax
	imulq	%r8, %rax
	leaq	(%rdx,%rax), %rsi
	movq	%r8, %rax
	mulq	%rcx
	leaq	(%rsi,%rdx), %rcx
	movq	%rcx, %rdx
	movq	-24(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	nop
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	store_uprod, .-store_uprod
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
