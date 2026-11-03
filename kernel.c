// Pretty surprising that they are all headers! 
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

// In C, anything that is # are preprocessor directive
#if defined(__linux__)
#error "Bro not using a cross-compiler, probably run into trouble soon!"
#endif

// This only works with 32-bit ix86 targets
#if !defined(__i386__)
#error "This project only cooks with i386"
#endif

// Hardware text mode color const
enum vga_color {
    VGA_COLOR_BLACK = 0,
	VGA_COLOR_BLUE = 1,
	VGA_COLOR_GREEN = 2,
	VGA_COLOR_CYAN = 3,
	VGA_COLOR_RED = 4,
	VGA_COLOR_MAGENTA = 5,
	VGA_COLOR_BROWN = 6,
	VGA_COLOR_LIGHT_GREY = 7,
	VGA_COLOR_DARK_GREY = 8,
	VGA_COLOR_LIGHT_BLUE = 9,
	VGA_COLOR_LIGHT_GREEN = 10,
	VGA_COLOR_LIGHT_CYAN = 11,
	VGA_COLOR_LIGHT_RED = 12,
	VGA_COLOR_LIGHT_MAGENTA = 13,
	VGA_COLOR_LIGHT_BROWN = 14,
	VGA_COLOR_WHITE = 15,
};

// static here mean this function only lives in this file 
// inline here is like a hint for the compiler that instead of calling this function
// can just copy and paste this function over where it needs
// compiler can refuse the copy if it considers not optimized 
static inline uint8_t vga_entry_color(enum vga_color fg, enum vga_color bg) {
    // << has higher precedence than | so
    // this one is bg left shift by 4 first
    // before OR with fg
    return fg | bg << 4;
};

// each char will have 16 bits, 8 for colors, 8 for content
// this function is to return a char with its attribute
static inline uint16_t vga_entry(unsigned char uc, uint8_t color) {
	return (uint16_t) uc | (uint16_t)  color << 8 ;
}

size_t strlen(const char* str) {
	size_t len = 0;
	while(str[len]) {
		len++;
	}
	return len;
}

#define VGA_WIDTH 80
#define VGA_HEIGHT 25

// defined macro therefore, preprocessor replaces VGA_MEMORY with 0xB8000 before compiling
#define VGA_MEMORY 0xB8000 // memory mapped io! 

size_t terminal_row;
size_t terminal_column;
uint8_t terminal_color;

// (uint16_t*) is casting
// terminal_buffer is a uint16_t poitner that has value 0xB8000 
// type of pointer here is uint16_t but its size is actually 32 bit!  
// pointer size depends on hardware + compiler
uint16_t* terminal_buffer = (uint16_t*)VGA_MEMORY;


void terminal_initialize(void) {
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);

	for (size_t y = 0; y < VGA_HEIGHT; y++) {
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			const size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}	
	}
}

void terminal_setcolor(uint8_t color) {
	terminal_color = color;
}

void terminal_putentryat(char c, uint8_t color, size_t x, size_t y) {
	const size_t index = y * VGA_WIDTH + x;
	terminal_buffer[index] = vga_entry(c, color);
}

void terminal_putchar(char c) {
	terminal_putentryat(c, terminal_color, terminal_column, terminal_row);
	if (++terminal_column == VGA_WIDTH) {
		terminal_column = 0; 
		if (++terminal_row == VGA_HEIGHT) {
			terminal_row = 0;
		}
	}
}

void terminal_write(const char* data, size_t size) {
	for (size_t i = 0; i < size; i++) {
		terminal_putchar(data[i]);
	}
}

void terminal_writestring(const char* data) {
	terminal_write(data, strlen(data));
}

void kernel_main(void) {
	// init the terminal
	terminal_initialize();

	// Hello world printing
	terminal_writestring("Za Warudo!\n");
}