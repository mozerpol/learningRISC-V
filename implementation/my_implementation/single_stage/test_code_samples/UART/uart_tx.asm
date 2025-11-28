###################################
##         Check UART tx         ##
###################################
addi  x3,  x0,   0x44  # x3 = 0x00000044, 0x44 = D in ascii
addi  x4,  x0,   0xD   # x4 = 0x0000000d, 0xD = new line sign in ascii

sw    x3,  243(x0)     # Send sign D by UART
loop29:
lw    x1,  239(x0)     # Load UART status bit to x1 register
bne   x1,  x0,   loop29 # Check if uart tx is busy
addi  x3,  x0,   0     # x3 = 0x00000000

sw    x4,  243(x0)     # Send new line sign by UART
loop30:
lw    x2,  239(x0)     # Load UART status bit to x2 register
bne   x2,  x0,   loop30 # Check if uart tx is busy
addi  x4,  x0,   0     # x4 = 0x00000000
