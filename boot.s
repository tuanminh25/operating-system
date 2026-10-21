

/* 
Declare constants for the multiboot header 
Todo: 
why it is needed and why do we even need a multiboot as well?
- Multiboot is a contract, like an API
- bootloader software will read this contract and figure out which boot protocol it should boot this os with

what does a multiboot header do ? 
- component of multiboot contract, provide things for the bootloader to know how to boot
*/ 

.set ALIGN, 1<<0
.set MEMINFO, 1<<1
.set FLAGS, ALIGN | MEMINFO
.set MAGIC, 0x1BADB002
.set CHECKSUM, -(MAGIC + FLAGS)


/*
Declare that this file is kernel file
Bootloader would:
- search for this signature
- in the first 8kib of kernel file, 
- aligned at a 32 bit boundary 
*/
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/*
  Reserve 16 kib for the stack for C - because C need stack to operate! 
*/
.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top:

/*
  Everything above is declaration

  Code for kernel starts after _start
*/
.section .text
.global _start /* make _start visible to linker */
.type _start, @function
_start:

    mov $stack_top, %esp  /* move stack top address into esp*/


        /*
        ; Placeholder intend for:
        ; - loading GDT
        ; - enabling paging
        ; - turning on floating-point unit 

        ; Handling control from assembly code to C code
        ; kernel_main is a function name in C // TODO: double check this is what I suppose

        ; boot.s will jump away at this point ! it will jump to kernel C in C code
        */
    
    call kernel_main


    /*
    ; When returned from kernel_main:
    ; clear interupt flag with cli
    */
    cli

    # infinite loop with those combo
    1: hlt
    jmp 1b

# Meta data - end of _start code 
.size _start, . - _start


/*
result:

    i686-elf-nm boot.o
    
    the number is the offset - not final address yet! 

    00000001 a ALIGN
    e4524ffb a CHECKSUM
    00000003 a FLAGS
            U kernel_main
    1badb002 a MAGIC
    00000002 a MEMINFO
    00000000 b stack_bottom
    00004000 b stack_top
    00000000 T _start


*/