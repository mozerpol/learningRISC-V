# JAL instruction
jal  x1,  4        # PC = 4, go to PC = 8
jal  x2,  4        # PC = 8, go to PC = 12
jal  x3,  8        # PC = 12, go to PC = 20
jal  x4,  8        # PC = 16, go to PC = 24 
jal  x5,  -4       # PC = 20, go to PC = 16
addi x6,  x0, 0xff # PC = 24
addi x7,  x0, 24   # PC = 28
addi x8,  x0, 80   # PC = 32
jal  x6,  4        # PC = 36, go to PC = 40
addi x18, x0, 0xff # PC = 40
addi x9,  x0, 4    # PC = 44
addi x10, x0, 8    # PC = 48
# JALR instruction
jalr x11, 52(x0)   # PC = 52, go to PC = 56
jalr x12, 32(x7)   # PC = 56, go to PC = 60
jalr x14, -20(x8)  # PC = 60, go to PC = 64
addi x9,  x1, 1    # PC = 64
