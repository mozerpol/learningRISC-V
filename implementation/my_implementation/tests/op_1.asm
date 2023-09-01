# Set initial GPR values
addi x1,  x0, 1
addi x2,  x0, -1
addi x3,  x0, 2
addi x4,  x0, -2
lui  x5,  0x12345
addi x5,  x5, 0x678
lui  x6,  0xFFFFF
addi x6,  x6, 0xFF
# ADD instruction
add  x7,  x1, x2
add  x8,  x2, x1
add  x9,  x3, x4
add  x10, x5, x6
add  x11, x6, x5
# SUB instruction
sub  x12, x1, x2
sub  x13, x2, x1
sub  x14, x3, x4
sub  x15, x5, x6
sub  x16, x6, x5
# SLL instruction
sll  x17, x1, x2
sll  x18, x2, x1
sll  x19, x3, x4
sll  x20, x5, x6
sll  x21, x6, x5
# SLT instruction
slt  x22, x1, x2
slt  x23, x2, x1
slt  x24, x3, x4
slt  x25, x5, x6
slt  x26, x6, x5
# SLTU instruction
sltu x27, x1, x2
sltu x28, x2, x1
sltu x29, x3, x4
sltu x30, x5, x6
sltu x31, x6, x5
