┌─────────────────────┐
│ ELF header          │  "I'm ELF, x86-64; the section table is at offset N"
├─────────────────────┤
│ .text               │  machine code bytes (with zeros in the holes)
│ .data               │  initialized variables
│ .bss                │  (size only, zero-filled at load)
│ .symtab             │  names: "inc is at .text+0", "counter is undefined"
│ .strtab             │  the actual name strings
│ .rela.text          │  "patch .text offset 3 with address of counter"
├─────────────────────┤
│ Section header table│  list of where each section starts and how big it is
└─────────────────────┘

objdump read this table and give us info

compiling works only on one file at a time, but linking needs all file together 
-> that is why object file is needed
