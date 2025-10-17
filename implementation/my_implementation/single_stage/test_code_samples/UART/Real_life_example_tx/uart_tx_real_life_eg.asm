# First, the character D is sent, and then the newline character in an infinite
# loop.
loop3:
addi  x1,  x0,   0x44  # 0x44 = D in ascii
addi  x2,  x0,   0xD   # 0xD = new line sign in ascii

sw    x1,  243(x0)     # Send sign D by UART
loop1:
lw    x3,  239(x0)     # Load UART status bit to x3 register
bne   x3,  x0,   loop1 # Check if uart tx is busy

sw    x2,  243(x0)     # Send new line sign by UART
loop2:
lw    x3,  239(x0)     # Load UART status bit to x3 register
bne   x3,  x0,   loop2 # Check if uart tx is busy

j loop3
