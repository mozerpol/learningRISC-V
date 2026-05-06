addi  x1,  x0,   0x395 # x1 = 0x00000395, where:
# 0x95 - slave address
# 0x3 - number of bytes to send
# 0x0 - R/W bit - write to slave

lui   x2,  0xE7C       # x2 = 0x00E7C000, data to send
addi  x2,  x2,   0x381 # x2 = 0x00E7C381 = 00000000 11100111 11000011 10000001
addi  x3,  x0,   0     # x3 = 0x00000000

sw    x1,  32(x0)      # Send address, number of bytes to send and R/W bit to I2c controller
sw    x2,  36(x0)      # Send data by I2C

loop37:
lw    x3,  44(x0)      # Load I2C status bit to x3 register
andi  x3,  x3    0x1   # Check only LSB
bne   x3,  x0,   loop37# Check if I2C tx is busy, when = 1, then jump to loop37

addi  x1,  x0,   0x1   # x1 = 0x00000001
addi  x1,  x1,   0x1   # x1 = 0x00000002
addi  x1,  x1,   0x1   # x1 = 0x00000003
