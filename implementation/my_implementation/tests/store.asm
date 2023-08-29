# Set initial GPR values
addi x1,  x0, 1
addi x2,  x0, 2
addi x3,  x0, -4
addi x4,  x0, 18
addi x5,  x0, 12
lui  x6,  0x12345 
addi x6,  x6, 0x678
lui  x7,  0xABCDE
addi x7,  x7, 0xFF
# SB instruction
sb   x6,  0(x0)  # RAM[0]
sb   x6,  1(x0) 
sb   x6,  1(x1)
sb   x6,  1(x2)
sb   x6,  2(x2)
sb   x7,  9(x3)  # RAM[5]
sb   x7,  -6(x5) # RAM[6]
# SH instruction
sh   x6,  8(x0)  # RAM[8]
sh   x6,  8(x2)  # RAM[10]
sh   x7,  -6(x4) # RAM[12]
sh   x7,  18(x3) # RAM[14]
# SW instruction
sw   x6,  -2(x4) # RAM[16]
sw   x6,  2(x4)  # RAM[20]
sw   x7,  28(x3) # RAM[24]
sw   x7,  28(x0) # RAM[28]
