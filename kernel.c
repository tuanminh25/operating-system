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
}

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