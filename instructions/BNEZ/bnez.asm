addi x1, x0, 0 # reset x1
isNotEqualZero:
	addi x1, x0, 0x1 # add 0x1 to x1 register 
	bnez 	x1, isNotEqualZero # if register x1 is not equal 0 then jump to 
	                           # isNotEqualZero label  
