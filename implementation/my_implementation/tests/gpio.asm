# Set initial GPR values
addi x1,  x0, 1
addi x2,  x0, 2
addi x3,  x0, 0xf
addi x4,  x0, 251
# SB instruction
sb   x0,  0(x0)   # gpio = xxxx
sb   x1,  255(x0) # gpio = 0001
sb   x2,  4(x4)   # gpio = 0010
sb   x3,  255(x0) # gpio = 1111
sb   x0,  255(x0) # gpio = 0000
