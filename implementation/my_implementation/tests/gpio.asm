# Set initial GPR values
addi x1,  x0, 1
addi x2,  x0, 2
addi x3,  x0, 4
addi x4,  x0, 8
addi x5,  x0, 0xf
addi x6,  x0, 251
# SB instruction
sb   x0,  0(x0)   # gpio = xxxx
sb   x1,  255(x0) # gpio = 0001
sb   x2,  4(x6)   # gpio = 0010
sb   x3,  255(x0) # gpio = 0100
sb   x4,  255(x0) # gpio = 1000
sb   x5,  255(x0) # gpio = 1111
sb   x0,  255(x0) # gpio = 0000
