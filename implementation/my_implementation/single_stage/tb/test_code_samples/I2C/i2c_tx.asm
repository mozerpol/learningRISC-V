addi  x1,  x0,   0x395 # x1 = 0x00000395, where:
# 0x95 - slave address
# 0x3 - number of bytes to send
# 0x0 - R/W bit - write to slave

lui   x2,  0xE7C       # x2 = 0x00E7C000, data to send
addi  x2,  x2,   0x381 # x2 = 0x00E7C381 = 00000000 11100111 11000011 10000001

sw    x1,  32(x0)      # Send address, number of bytes to send and R/W bit to I2c controller
sw    x2,  36(x0)      # Send data by I2C
