addi  x1,  x0,   0     # x1 = 0x00000000
addi  x2,  x0,   0     # x2 = 0x00000000
sw    x0,  24(x0)      # Start SPI read data
loop36:
lw    x2,  28(x0)      # Load SPI status bit to x2 register
bne   x2,  x0,   loop36# Check if uart rx is busy
lw    x1,  24(x0)      # Load received data on SPI to x1 register

addi  x1,  x0,   0     # x1 = 0x00000000
addi  x1,  x0,   1     # x1 = 0x00000001
addi  x1,  x0,   1     # x1 = 0x00000002
addi  x1,  x0,   1     # x1 = 0x00000003
