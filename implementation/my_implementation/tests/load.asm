# Set initial GPR values
addi x1,  x0, 1
addi x2,  x0, 2
addi x3,  x0, 0
addi x9,  x0, 1234 # 0x42d
addi x10, x0, 2
addi x11, x0, 0xAB
addi x12, x0, 0xAB
addi x18, x0, 1234
addi x19, x0, -10
addi x20, x0, -10
lui  x24, 0xABABA 
addi x24, x24, 0xBA
lui  x25, 0xABABA 
addi x25, x25, 0xBA
lui  x26, 0x12345
addi x26, x26, 0x678
addi x28, x28, 0x1
addi x31, x31, 0x3
# Set initial RAM values
sw   x26, 0(x0)
sw   x0,  4(x0)
sw   x24, 8(x0)
# LB instruction
lb   x3,  0(x0) # load a positive number from RAM[0]
lb   x4,  1(x0) # load a positive number from RAM[1]
lb   x5,  2(x0) # load a positive number from RAM[2]
lb   x6,  2(x1) # load a positive number from RAM[2+1]
lb   x7,  2(x2) # load a positive number from RAM[2+2]
lb   x8,  8(x0) # load a negative number from RAM[8]
lb   x9,  0(x0) # load a positive number from RAM[0] when x9 contains a positive number
lb   x10, 8(x0) # load a negative number from RAM[8] when x10 contains a positive number
lb   x11, 0(x0) # load a positive number from RAM[0] when x11 contains a negative number
lb   x12, 8(x0) # load a negative number from RAM[8] when x12 contains a negative number
# LH instruction
lh   x13, 0(x0) # same operating principle as before...
lh   x14, 1(x0)
lh   x15, 2(x0)
lh   x16, 2(x2)
lh   x17, 8(x0)
lh   x18, 0(x0)
lh   x19, 0(x0)
lh   x20, 8(x0)
# LW instruction
lw   x21, 0(x0)
lw   x22, 2(x2)
lw   x23, 8(x0)
lw   x24, 0(x0)
lw   x25, 8(x0)
# LBU instruction
lbu  x26, 0(x0)
lbu  x27, 8(x0)
lbu  x28, 8(x0)
# LHU instruction
lhu  x29, 1(x1)
lhu  x30, 8(x2)
lhu  x31, 8(x0)
