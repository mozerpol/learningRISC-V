###################################
##         Check SPI tx          ##
###################################
addi  x1,  x1,   789   # Delay purposes, x1 = 789, 0x315
addi  x2,  x0,   0
addi  x3,  x0,   0xff
lui   x4,  699051
addi  x4,  x4,   -1366 # x4 = 0x AAAAAAAA
sw    x3,  239(x0)     # Send the value stored in the register x3
loop32:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop32# Is there enough delay? No: go to loop32
addi  x2,  x0,   0
sw    x4,  239(x0)     # Send the value stored in the register x4
loop33:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop33# Is there enough delay? No: go to loop32
addi  x2,  x0,   0
