SIGSEGV = segmentation fault

every memory access go through CPU's MMU (memory management unit) which checks the page table that says for each 4Kib page:
- is it mapped?
- is it readable?
- is it writable?
- is it executable?

if touch an unmapped page or break a permission -> SIGSEGV fault

