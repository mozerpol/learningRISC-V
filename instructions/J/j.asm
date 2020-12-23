loop:
    addi 	x5, x5, 1 # increment x5
    addi 	x5, x5, 1 # increment x5
j loop # jump to loop and save PC status in x0, so don't save status.
