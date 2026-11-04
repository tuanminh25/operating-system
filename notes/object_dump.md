# Frequent flags
i686-elf-objdump -h -t -d -r *.o


-h: section header

-t: symbol table

-d -r: dissembly and relocation(fix up an address once final location is known)

# How to read any line

1. i686-elf-objdump -d -r -M intel boot.o

Disassembly of section .text:
- self explanatory! 

00000000 <_start>:
^            ^
|            |
start addr   symbol defined at this offset

   0:   bc 00 40 00 00          mov    esp,0x4000
   ^           ^                 ^
   |           |                 |
offset    raw machine byte      human readable instruction

                        1: R_386_32            .bss
                        ^     ^                 ^
                        |     |                 |
          offset to patch   how to patch      relative to what





   5:   e8 fc ff ff ff          call   6 <_start+0x6>
                        6: R_386_PC32   kernel_main

normally a patch would be generated right after where it needed

   a:   fa                      cli
   b:   f4                      hlt
   c:   eb fd                   jmp    b <_start+0xb>


2. i686-elf-objdump -r boot.o

boot.o:     file format elf32-i386

RELOCATION RECORDS FOR [.text]:
OFFSET   TYPE              VALUE
00000001 R_386_32          .bss
00000006 R_386_PC32        kernel_main


# Symbol table

00000000  g     F  .text   0000000e  _start
↑         ↑     ↑  ↑       ↑         ↑
value     scope type section SIZE    name
(offset)

scope can be l(local) or g(global)
"*ABS*" is an plain constraint

