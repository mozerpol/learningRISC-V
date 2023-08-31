# Set initial GPR values
addi  x1, x0, 1
addi  x2, x0, 2
addi  x3, x0, -1
addi  x4, x0, 0xff
addi  x5, x0, 4
addi  x6, x0, 8
addi  x7, x0, -4
addi  x8, x0, -8
addi  x9, x0, 0
# BEQ instruction
beq   x3, x4, 8
auipc x10, 0
beq   x0, x9, 8
beq   x0, x9, 12
auipc x11, 0
beq   x0, x9, -8
beq   x5, x7, 8
auipc x12, 0
# BNE instruction
bne   x3, x4, 8
addi  x0, x0, 0
auipc x13, 0
bne   x5, x4, 8
bne   x1, x2, 12
auipc x14, 0
bne   x7, x8, -8
auipc x15, 0
bne   x9, x0, 8
# BLT instruction
blt   x2, x1, 8
blt   x1, x2, 8
addi  x0, x0, 0
auipc x16, 0
blt   x8, x4, 12
auipc x18, 0
blt   x0, x4, 12
auipc x17, 0
blt   x3, x4, -12
auipc x19, 0
blt   x9, x0, 8
auipc x20, 0
# BGE instruction
bge   x7, x5, 12
auipc x21, 0
bge   x6, x8, 8
addi  x0, x0, 0
bge   x4, x3, 4
auipc x22, 0
bge   x9, x0, 4
bge   x6, x5, 4
bge   x5, x6, 4
auipc x24, 0
# BLTU instruction
bltu  x7, x8, 12
auipc x25, 0
bltu  x1, x2, 8
bltu  x5, x7, 16
bltu  x9, x0, 12
auipc x26, 0
bltu  x4, x3, -12
auipc x27, 0
addi  x0, x0, 0
# Set initial GPR values
addi  x1, x0, 1
addi  x2, x0, 2
addi  x3, x0, -1
addi  x4, x0, 0xff
addi  x5, x0, 4
addi  x6, x0, 8
addi  x7, x0, -4
addi  x8, x0, -8
addi  x9, x0, 0
# BGEU instruction
bgeu  x1, x2, -12
bgeu  x8, x7, -12
auipc x28, 0
bgeu  x9, x0, 8
addi  x0, x0, 0
auipc x29, 0
bgeu  x5, x7, 12
auipc x30, 0
bgeu  x6, x8, 8
addi  x0, x0, 0
bgeu  x3, x4, 8
addi  x0, x0, 0
auipc x31, 0
