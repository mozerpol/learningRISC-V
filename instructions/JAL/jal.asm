loop:
    addi 	x5, x5, 1 # increment x5
    addi 	x5, x5, 1 # increment x5
jal 	x4, loop # go to loop and save 0xC in x4 reg. 0xC = PC status
