###################################
##         Check UART rx         ##
###################################
lui   x1,  0x3D0
addi  x1,  x1,   2047
addi  x1,  x1,   257   # 3D0900 = 4000000, x4 is compared with x3. For 40 MHz it
# is about 1 sec delay
addi  x2,  x0,   0     # Counter
addi  x3,  x0,   1     # For LED

loop1:
addi  x2,  x2,   1     # Increment x3
bne   x1,  x2,   loop1 # Is there enough delay? No: go to loop1
addi  x2,  x0,   0     # Reset counter
lw    x10, 247(x0)     # Save incoming data on UART in x10 reg
beq   x10, x0,   loop1 # If any data was received on UART then go to the next
# instruction, if not then go to loop1
sb    x3,  255(x0)     # Turn on LED
