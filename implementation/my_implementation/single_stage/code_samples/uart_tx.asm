###################################
##         Check UART tx         ##
###################################
lui   x1,  2441
addi  x1,  x1,   1664  # Long loop purposes
addi  x2,  x0,   0
lui   x4,  0x41505     # Load upper 20 bits
ori   x4,  x4,   0x544 # Load lower 12 bits
addi  x5,  x0,   0xD   # New line sign

loop1:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop1 # Is there enough delay? No: go to loop1
addi  x2,  x0,   0     # Reset x2
sw    x4,  247(x0)     # Send data by UART, 0xDUPA

lui   x6,  0xf         # Short loop purposes
loop2:
addi  x6,  x6,   -1
bne   x6,  x0,   loop2 # Is there enough delay? No: go to loop2
sw    x5,  247(x0)     # Send data by UART, a new line sign

j loop1
