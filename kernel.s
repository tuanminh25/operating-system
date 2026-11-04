	.file	"kernel.c"
	.text
	.type	vga_entry_color, @function
vga_entry_color:
	pushl	%ebp
	movl	%esp, %ebp
	movl	12(%ebp), %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	orl	%edx, %eax
	popl	%ebp
	ret
	.size	vga_entry_color, .-vga_entry_color
	.type	vga_entry, @function
vga_entry:
	pushl	%ebp
	movl	%esp, %ebp
	movzbl	8(%ebp), %edx
	movzbl	12(%ebp), %eax
	sall	$8, %eax
	orl	%edx, %eax
	popl	%ebp
	ret
	.size	vga_entry, .-vga_entry
	.globl	strlen
	.type	strlen, @function
strlen:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	.L6
.L7:
	addl	$1, -4(%ebp)
.L6:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L7
	movl	-4(%ebp), %eax
	leave
	ret
	.size	strlen, .-strlen
	.globl	terminal_row
	.section	.bss
	.align 4
	.type	terminal_row, @object
	.size	terminal_row, 4
terminal_row:
	.zero	4
	.globl	terminal_column
	.align 4
	.type	terminal_column, @object
	.size	terminal_column, 4
terminal_column:
	.zero	4
	.globl	terminal_color
	.type	terminal_color, @object
	.size	terminal_color, 1
terminal_color:
	.zero	1
	.globl	terminal_buffer
	.data
	.align 4
	.type	terminal_buffer, @object
	.size	terminal_buffer, 4
terminal_buffer:
	.long	753664
	.text
	.globl	terminal_initialize
	.type	terminal_initialize, @function
terminal_initialize:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
	movl	$0, terminal_row
	movl	$0, terminal_column
	pushl	$0
	pushl	$7
	call	vga_entry_color
	addl	$8, %esp
	movb	%al, terminal_color
	movl	$0, -8(%ebp)
	jmp	.L10
.L13:
	movl	$0, -12(%ebp)
	jmp	.L11
.L12:
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -16(%ebp)
	movzbl	terminal_color, %eax
	movl	terminal_buffer, %edx
	movl	-16(%ebp), %ecx
	addl	%ecx, %ecx
	leal	(%edx,%ecx), %ebx
	movzbl	%al, %eax
	pushl	%eax
	pushl	$32
	call	vga_entry
	addl	$8, %esp
	movw	%ax, (%ebx)
	addl	$1, -12(%ebp)
.L11:
	cmpl	$79, -12(%ebp)
	jbe	.L12
	addl	$1, -8(%ebp)
.L10:
	cmpl	$24, -8(%ebp)
	jbe	.L13
	nop
	nop
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	terminal_initialize, .-terminal_initialize
	.globl	terminal_setcolor
	.type	terminal_setcolor, @function
terminal_setcolor:
	pushl	%ebp
	movl	%esp, %ebp
	movzbl	8(%ebp), %eax
	movb	%al, terminal_color
	nop
	popl	%ebp
	ret
	.size	terminal_setcolor, .-terminal_setcolor
	.globl	terminal_putentryat
	.type	terminal_putentryat, @function
terminal_putentryat:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$16, %esp
	movl	20(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -8(%ebp)
	movzbl	8(%ebp), %edx
	movl	terminal_buffer, %eax
	movl	-8(%ebp), %ecx
	addl	%ecx, %ecx
	leal	(%eax,%ecx), %ebx
	movzbl	12(%ebp), %eax
	pushl	%eax
	movzbl	%dl, %eax
	pushl	%eax
	call	vga_entry
	addl	$8, %esp
	movw	%ax, (%ebx)
	nop
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	terminal_putentryat, .-terminal_putentryat
	.globl	terminal_putchar
	.type	terminal_putchar, @function
terminal_putchar:
	pushl	%ebp
	movl	%esp, %ebp
	movl	terminal_row, %edx
	movl	terminal_column, %eax
	movzbl	terminal_color, %ecx
	pushl	%edx
	pushl	%eax
	movzbl	%cl, %eax
	pushl	%eax
	movsbl	8(%ebp), %eax
	pushl	%eax
	call	terminal_putentryat
	addl	$16, %esp
	movl	terminal_column, %eax
	addl	$1, %eax
	movl	%eax, terminal_column
	movl	terminal_column, %eax
	cmpl	$80, %eax
	jne	.L18
	movl	$0, terminal_column
	movl	terminal_row, %eax
	addl	$1, %eax
	movl	%eax, terminal_row
	movl	terminal_row, %eax
	cmpl	$25, %eax
	jne	.L18
	movl	$0, terminal_row
.L18:
	nop
	leave
	ret
	.size	terminal_putchar, .-terminal_putchar
	.globl	terminal_write
	.type	terminal_write, @function
terminal_write:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	.L20
.L21:
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	pushl	%eax
	call	terminal_putchar
	addl	$4, %esp
	addl	$1, -4(%ebp)
.L20:
	movl	-4(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	.L21
	nop
	nop
	leave
	ret
	.size	terminal_write, .-terminal_write
	.globl	terminal_writestring
	.type	terminal_writestring, @function
terminal_writestring:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	8(%ebp)
	call	strlen
	addl	$4, %esp
	pushl	%eax
	pushl	8(%ebp)
	call	terminal_write
	addl	$8, %esp
	nop
	leave
	ret
	.size	terminal_writestring, .-terminal_writestring
	.section	.rodata
.LC0:
	.string	"Za Warudo!\n"
	.text
	.globl	kernel_main
	.type	kernel_main, @function
kernel_main:
	pushl	%ebp
	movl	%esp, %ebp
	call	terminal_initialize
	pushl	$.LC0
	call	terminal_writestring
	addl	$4, %esp
	nop
	leave
	ret
	.size	kernel_main, .-kernel_main
	.ident	"GCC: (GNU) 16.2.0"
