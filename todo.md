Ref: master link: https://wiki.osdev.org/Creating_an_Operating_System


Even smaller focus right now:
boot.s - using GNU assembler - done
next - for tomorrow - kernel.c

we are exploring or just explored VGA text mode from this section:
Freestanding and Hosted Environments

So for tomorrow: briefly read it again: 
Freestanding and Hosted Environments

and then move onto
Writing a kernel in C

https://wiki.osdev.org/Bare_Bones


Smaller focus right now:

boot.s - kernel entry point that sets up the processor environment
kernel.c - your actual kernel routines
linker.ld - for linking the above files



prerequisite that we have done: 

cross compiler


Big generic scary one, just look for now, will tick later:

The GNU Linker from Binutils to link your object files into the final kernel.
The GNU Assembler from Binutils (or optionally NASM) to assemble instructions into object files containing machine code.
The GNU Compiler Collection to compile your high level code into assembly.
The C programming language (or optionally C++) to write the high level parts of your kernel.
The GRUB bootloader to bootload your kernel using the Multiboot boot protocol that loads us into 32-bit protected mode with paging disabled.
The ELF as the executable format that gives us control of where and how the kernel is loaded.