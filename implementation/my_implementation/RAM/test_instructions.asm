# Assign initial values
addi x1, x0, 0x1
addi x2, x0, 0x2
addi x3, x0, 0x3
lui  x4, 0x12345 
addi x4, x4, 0x678 # x4: 0x12345678
addi x5, x0, 0x0
addi x6, x0, 0x0
addi x7, x0, 0x0
# WRITE TO RAM
# SW
# RAM[0]: 78 56 34 12
sw   x4, 0(x0)
# SH
# RAM[1]: 78 56 -- --
sh   x4, 4(x0)
# SB
# RAM[2]: 78 -- -- --
sb   x4, 8(x0)
# Check saving to different addresses
# SW
# RAM[3]: -- 78 56 34
# RAM[4]: 12 -- -- --
sw   x4, 12(x1)
# SH
# RAM[5]: -- -- 78 56
sh   x4, 20(x2)
# SB
# RAM[6]: -- -- -- 78
sb   x4, 24(x3)
# READ FROM RAM
# LW
# x5: 0x56781234
lw   x5, 1(x1)
# LH
# x6: 0x00005678
lh   x6, 2(x2)
# LB
# x7: 0x00000012
lb   x7, 0(x3)
