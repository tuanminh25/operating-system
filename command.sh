# Compile the assembly boot
i686-elf-as boot.s -o boot.o

# Compile the C kernel
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

# Compile the C++ kernel
# i686-elf-g++ -c kernel.c++ -o kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

# Linking them via linker script
i686-elf-gcc -T linker.ld -o myos -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

# objdump inspect
# i686-elf-objdump -h -t -d -r *.o
# 
