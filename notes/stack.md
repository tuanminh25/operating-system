# Stack role

It is heavy in traffic while heap is heavy in bytes. Every function call uses it for the return address, arguments, locals, saved registers. It is extrememly fast (allocating it is just moving the esp)