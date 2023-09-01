# Set initial GPR values
addi x1,  x0, 1
addi x2,  x0, -1
addi x3,  x0, 2
addi x4,  x0, -2
lui  x5,  0x12345
addi x5,  x5, 0x678
lui  x6,  0xFFFFF
addi x6,  x6, 0xFF
# XOR instruction
xor  x7,  x1, x2
xor  x8,  x2, x1
xor  x9,  x3, x4
xor  x10, x5, x6
xor  x11, x6, x5
# SRL instruction
srl  x12, x1, x2
srl  x13, x2, x1
srl  x14, x3, x4
srl  x15, x5, x6
srl  x16, x6, x5
# SRA instruction
sra  x17, x1, x2
sra  x18, x2, x1
sra  x19, x3, x4
sra  x20, x5, x6
sra  x21, x6, x5
# OR instruction
or   x22, x1, x2
or   x23, x2, x1
or   x24, x3, x4
or   x25, x5, x6
or   x26, x6, x5
# AND instruction
and  x27, x1, x2
and  x28, x2, x1
and  x29, x3, x4
and  x30, x5, x6
and  x31, x6, x5
