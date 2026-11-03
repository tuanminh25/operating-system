i686-elf-gcc -dM -E - < /dev/null | grep __SIZE_TYPE__
#define __SIZE_TYPE__ long unsigned int


size_t is a type defined inside the compiler
through a 32 bit compiler, each size_t is 32 bit 
through a 64 bit compiler, each size_t is 64 bit 

