# o0 vs o2

i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
this does optimization with hint things like inline + rewrite aggresively to make things faster even if harder to read 

i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O0 -Wall -Wextra
translate C almost line by line , no inline, easier to read debug but slower 




