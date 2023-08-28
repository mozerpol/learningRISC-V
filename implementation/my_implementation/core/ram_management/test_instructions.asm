# Assign initial values
addi ra, zero, 0x1
addi x2, x0, 0x2
addi x3, x0, 0x3
lui  x4, 0x12345 
addi x4, x4, 0x678 # x4: 0x12345678
addi x5, x0, 0x0
addi x6, x0, 0x0
addi x7, x0, 0x0

sw   x0, 0(x0)
sw   x0, 4(x0)
sw   x0, 8(x0)
sw   x0, 12(x0)
sw   x0, 16(x0)
sw   x0, 20(x0)

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
# SH
# RAM[3]: -- -- 78 56
sh   x4, 12(x2)
# SB
# RAM[4]: -- 78 -- --
sb   x4, 16(x1)
# READ FROM RAM
# LW
# x5: 0x12345678
#lw   x5, 0(x0)
# LH
# x6: 0x00001234
#lh   x6, 1(x1)
# LB
# x7: 0x00000012
#lb   x7, 0(x3)
