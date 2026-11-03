// (uint16_t*) is casting
// terminal_buffer is a uint16_t poitner that has value 0xB8000 
// type of pointer here is uint16_t but its size is actually 32 bit!  
// pointer size depends on hardware + compiler
uint16_t* terminal_buffer = (uint16_t*)VGA_MEMORY;

