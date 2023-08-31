# ADDI instruction
addi  x1, x0, -1
addi  x2, x0, -2
addi  x3, x0, -1
addi  x3, x3, 2
lui   x4, 0x12345
addi  x4, x4, 0x678
addi  x4, x4, -1
addi  x5, x0, -1
addi  x5, x2, 0
# SLTI instruction
slti  x6, x6, 0
slti  x7, x1, -2
slti  x8, x5, -1
slti  x9, x3, 1
slti  x10, x4, -1
# SLTIU instruction
sltiu x11, x11, 0
sltiu x12, x1, -2
sltiu x13, x5, -1
sltiu x14, x3, 1
sltiu x15, x4, -1
# XORI instruction
xori  x15, x1, 1
xori  x16, x1, 0
xori  x17, x4, 21
xori  x18, x4, -21
xori  x19, x5, -1
# ORI instruction
ori   x20, x1, 1
ori   x21, x1, 0
ori   x22, x4, 21
ori   x23, x4, -21
ori   x24, x5, -1
ori   x25, x25, 0xFF
# ANDI instruction
andi  x26, x1, 1
andi  x27, x1, 0
andi  x28, x4, 21
andi  x29, x4, -21
andi  x30, x5, -1
andi  x31, x25, 0xFF
