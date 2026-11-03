# RAM

Never understands or knows what is address - only knows concept like bank, row, col

Address is handled by something called the memory controller in the motherboard or the CPU. And its job is to translate/convert flat mem like 0xsomething into actions like below:

The flow is CPU emit a series of address, the memory controller will manage those address and tells ram physically sequentially 
1. to activate row x 
2. read/write colum y 
then precharge  (closing/deactivating the row preping the next row in the same bank) 

Parallel works can happen since bank can operate independently from each other

Within one chip, every bank is the same size.

If a bank is a neighborhood with each cell being a house, then a chip is a city containing group of banks