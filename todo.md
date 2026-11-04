Master link: https://wiki.osdev.org/Creating_an_Operating_System
Our current page progress: https://wiki.osdev.org/Bare_Bones

# Current focus: Moving Forward
Next time visit, choose to explore:

Adding Support for Newlines to Terminal Driver
Implementing Terminal Scrolling
Rendering Colorful ASCII Art
Calling Global Constructors
Meaty Skeleton
Going Further
Bare Bones II

Also a quick look into: Frequently Asked Questions

### Prerequisite that we have done: 

cross compiler
boot.s + kernel.c + linker.ld booted on qemu

### Big generic scary one, just look for now, will tick later:

The GNU Linker from Binutils to link your object files into the final kernel.
The GNU Assembler from Binutils (or optionally NASM) to assemble instructions into object files containing machine code.
The GNU Compiler Collection to compile your high level code into assembly.
The C programming language (or optionally C++) to write the high level parts of your kernel.
The GRUB bootloader to bootload your kernel using the Multiboot boot protocol that loads us into 32-bit protected mode with paging disabled.
The ELF as the executable format that gives us control of where and how the kernel is loaded.