addi	x1, x0, 0 # reset x1 reg
addi	x2, x0, 0 # reset x2 reg
loop:
	addi 	x1, x1, 2 # add to x1 register number 2
	addi	x2, x2, 3 # add to x2 register number 3
	bne		x2, x1, loop # compare register x1 with x2, if values inside this
	                     # registers are different, then jump to "loop" label.
