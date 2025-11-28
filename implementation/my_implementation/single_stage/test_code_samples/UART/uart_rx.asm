###################################
##         Check UART rx         ##
###################################
addi  x1,  x0,   0xAB  # x1 = 0x000000AB
addi  x2,  x0,   0x12  # x2 = 0x00000012
addi  x3,  x0,   0xCD  # x3 = 0x000000CD
addi  x4,  x0,   0x99  # x4 = 0x00000099
addi  x5,  x0,   0     # x5 = 0x000000AB

loop31:
lw    x5,  243(x0)     # Load UART rx data register to x5 register
bne   x1,  x5   loop31 # Check if the UART received the data

loop32:
lw    x5,  243(x0)
bne   x2,  x5,   loop32

loop33:
lw    x5,  243(x0)
bne   x3,  x5,   loop33

loop34:
lw    x5,  243(x0)
bne   x4,  x5,   loop34

addi  x2,  x0,   0     # x2 = 0x00000000
addi  x2,  x2,   1     # x2 = 0x00000001
addi  x2,  x2,   1     # x2 = 0x00000002
addi  x2,  x2,   1     # x2 = 0x00000003
