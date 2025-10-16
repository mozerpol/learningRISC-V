###################################
##         Check UART tx         ##
###################################
lui   x1,  1           #	
addi  x1,  x1,   -1096 # Long loop purposes
addi  x2,  x0,   0
addi  x3,  x0,   0x44  # 0x44 = D in ascii
addi  x4,  x0,   0xD   # 0xD = new line sign in ascii

sw    x3,  243(x0)     # Send sign D by UART
loop1:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop1 # Is there enough delay? No: go to loop1
addi  x2,  x0,   0     # Reset x2

sw    x4,  243(x0)     # Send new line sign by UART
loop2:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop2 # Is there enough delay? No: go to loop1
