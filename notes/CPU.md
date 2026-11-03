CPU only knows register and memory address

Registers are handful of tiny slots inside CPU (eax, esp, eip,...)

Memory is the big RAM ouside, accessed by address. 

CPU whole job is moving data between those 2, doing math on it and choosing which instruction to go next

For the stack, there is a little on hardware help. it is just still "just memory" but the CPU has built in shortcuts for it : (esp, push, pop, call, ret). Heap and sections get 0 hardware help, they are entirely convention

