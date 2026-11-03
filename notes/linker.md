
# 3 main things:

1. After compiling step without linking, memory address in the object will have placeholder value. The linker will fill up any of those placeholder with actual data. Rule of thumbs of things will has place holder: any fixed home in memory (because this memory is decided by the linker)

```text

Thing	                                                Lives in	            Example
Global / static variables	                            .data / .bss	        int counter;
Functions (when called or their address is taken)	    .text	                kernel_main();
String literals and constants	                        .rodata	                "Hello"
Anything from another file	                            ? (unknown)	            boot.o calling kernel_main

```

Things do not need are: 

- Local var - lives on the stack , addresses are relative to stack pointer (esp + offset). Real address ony know at runtime so linker do not know at compiling time

- Jump inside 1 function, loop -  distance is known at compile time

- Plain number - just a value


For any linux program, the linker will start from a default mem addr number or start from whever the script say. The work of the linker is just going through consecutive segments, for each of those, just add offset being the size of each segment

Further clarification:

Both heap and stack are runtime, the linker only decided address for: code, globals, constants (size known in advance) segment of .text, .rodata, .data, .bss 

2. Symbol resolution: match names across files, in more detail:

file A calls function from file B. Linker is writing the B function address to file A so that the CPU knows where to jump to next

Matching will happen first before address giving step

3. Patching is the last step: rewriting all the place holder with actual address memory value

The full flow looks like:

1. Match:
- read all .o file + libs
- pair every "needs X" with one "define X" 
-> error here: undefined ref / multiple def

2. Layout: 
- walk linker.ld with the location counter
- place .text, .rodata, .data, .bss
-> every symbol now has a real addr

3. Patch: 
- go through every relocation note
- write the real address (or distance) into each hole

4. OUTPUT: the program