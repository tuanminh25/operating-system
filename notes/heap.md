Why large things go on the heap ? 

1. Because the stack memory is small and fixed (8MB in some hardware)
2. Dies on return: local vanish when function ends so cant really keep the data
3. Size must be known in advance, each function stack frame size is mostl fixed at compile time
4. Belong to one thread only 

