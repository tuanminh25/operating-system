# What is a cross compiler and why do I need it ? 

-  compiler meaning a code translator to binaries okay and we need this because bin for each os is different!(Linux, Win, Mac)

+ ELF on Linux, 
+ PE on Windows, 
+ Mach-O on Mac

###  "cross" meaning the compiler runs on one machine but produces code for another machine another os ! 

In this project it gonna be that:

cross compiler runs on my Linux host -> produce code for: bare metal i686 (no os)

pretty much simple like this

```text
C file → gcc (Linux)        → binary that assumes Linux exists
C file → i686-elf-gcc       → binary that assumes nothing exists
```

privilege is looked into at Runtime

### and the version i need is i686-elf -> this is the version that assumes no os, it outputs out directly ELF

ELF = Executable and Linkable Format - something that GRUB would need

