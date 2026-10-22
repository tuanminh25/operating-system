VGA = video graphic array - defines how the card works internally 

VGA has mode:

```text
                    | Graphic Mode          | Text Mode 
Write to memory     | Every pixel colors    | One char code per cell
See visually        | 640 x 480 pixels      | 80 cols x 25 rows character cells
Who draws the glyphs| implementer (me!)     | VGA (graphic) card 

```

Glyph: picture of letter
Font: Collection of Glyph 

In text mode, it still supports color! 
Each cells is 2 bytes 
- byte 1 is for character like 0x7A representing 'z'
- byte 2 is for attribute, holding the colors, has foreground bit and background bit
- in byte 2:
    bit 7 for blink - flash bit for char, can be configued to be 4th bg bit
    6 5 4 for bg  - total 2^3 = 8 colors
    3 2 1 0 for fg  - total 2^4 = 16 colors
    ![Bit layout VGA](<bit-layout-vga.png>)
    ref: https://en.wikipedia.org/wiki/VGA_text_mode


"Text buffer" "vga buffer": chunk of memory holding data that is waiting to be used by something else:
- vga text buffer = 80 cols x 25 rows x 2 = 4000 bytes starting at 0xB8000 (each cells is 2 byte!)
- we write to it
- the card constantly reads it and draws what's inside there

VGA standard is 70hz for 720x400 pixels or 70 read in 1 second in VGA text mode 

When I hook up a new montior with different res and refresh rate, it is 3 ways deal:
- Monitor say how much it can handle
- OS / graphic driver picks mode from that list 
- The graphic card will lift it

The VGA buffer location is hardcoded at 0xB8000
We have total of 25 rows each with 80 cols

Therefore for any input row and col, this is where we can calculate the position to add in our text:

origin offset + 2* size of each row * row input + 2 * col input 

or

```text
0xB8000 + 2 * 80 * row + 2 * col = 0xB8000 + 2 * ( 80 * row +  col )  
```

C lang bonus: 
C pointers already handle the x 2

```text
uint16_t* buf = (uint16_t*) 0xB8000;

buf[80 * y + x] = ...;   // compiler does the *2 automatically

// equivalent of

*(buf + 80 * y + x) = value; 
```

In C , square brakets work on any pointer! not just arrays
