Hex (base 16): digits 0–9, then A=10, B=11, C=12, D=13, E=14, F=15. Each position is worth ×16.

hex:      0x  1   0   0   0
position:     4096 256 16  1
→ 1×4096 = 4096


each number behind the 0x is represented by 4 bit. It can be something like

0x(6nums)
0x(4nums)
0x(2nums)
-> not limited

leading zero can be hidden 


quick math with hexa: normal number you borrow 10, now you borrow 16

Convert to decimal: same idea with binary: 

binary to decimal is  (0|1)*2^(position of bit) 
then hexa to decimal is  digit*16^(position of bit)

General rule is : digit * base ^ (position)

