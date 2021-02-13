la 		x1, array # load PC adress array label to x1 register 
lbu 	x2, 0(x1) # read first byte from label saved in x1 and save result in x2
lbu 	x3, 1(x1) # read second byte from label saved in x1 and save result in x2

.data # assembly directive
array:
	.asciiz "AB" # save "AB" string in memory
