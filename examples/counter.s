	.file	"counter.c"
	.text
	.p2align 4
	.globl	inc
	.type	inc, @function
inc:
	addl	$1, counter
	ret
	.size	inc, .-inc
	.globl	counter
	.data
	.align 4
	.type	counter, @object
	.size	counter, 4
counter:
	.long	5
	.ident	"GCC: (GNU) 16.2.0"
