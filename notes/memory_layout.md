This is roughly how Linux layouts a C program


 High addresses
 ┌──────────────┐
 │    Stack     │  local variables, return addresses (grows DOWN ↓)
 │      ↓       │
 │              │
 │      ↑       │
 │    Heap      │  malloc() memory (grows UP ↑)
 ├──────────────┤
 │    .bss      │  globals with no initial value (zeroed at start)
 ├──────────────┤
 │    .data     │  globals with initial values  (int x = 5;)
 ├──────────────┤
 │   .rodata    │  read-only constants          ("Hello" strings)
 ├──────────────┤
 │    .text     │  machine code (your functions)
 └──────────────┘
 Low addresses

