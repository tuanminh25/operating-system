
ENTRY(_start)

# What output sections to create
# which input sections go into each one
# in what order at what address

SECTIONS
{
    # . is the location counter
    # move cursor to address 0x200000 (2MiB)

    /*
     * Below 1M is reserved for BIOS data, VGA memoy,...
     * UEFI firmware sometimes uses mem around 1M so 2M is safer
     * Multiboot2 has a "relocatable kernel" feature that lets bootloader choose the address
     * However we are not using that feature so the address is hardcoded
     */
    . = 2M;

    # Create section named .text
    # Starting at the next 4K aligned address
    # 4k here just mean 4 * 1024 - K mean a unit suffix
    # BLOCK(4K) and ALIGN(4K) here doing the same thing
    # ":" normally just means that extra rules
    .text BLOCK(4K): ALIGN(4K)
    {
        /**
        * Syntax: FILE(SECTION)

        *                                        (.multiboot)
        which file (in this case is wild card)   which section inside them

         */
        *(.multiboot)
        *(.text)
    }


    /* Read-only data. */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

    /*
     * Read-write data (initialized)
     * Only store values in raw byte, not variable name
     * Variable lives in something called symbol table
     * PROGBITS type
     */
	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}
    
    /* 
     * Read-write data (uninitialized) and stack 
     * Same system with the data one but with different tag
     * Only record things like N bytes (no val)
     * At runtime the loader(GRUB) will let those have vals of 0s    
     * NOBITS type
    */
	.bss BLOCK(4K) : ALIGN(4K)
	{
        /*
         * COMMON is not a real section it is a internal linker thing
         * Hold uninit globals that might be declared in multiple files
         * linker merges them into 1 
         * GCC (10+) puts them straight into .bss instead
         * placing COMMON here mostly is for compability
         */
		*(COMMON) 
		*(.bss)
	}
}