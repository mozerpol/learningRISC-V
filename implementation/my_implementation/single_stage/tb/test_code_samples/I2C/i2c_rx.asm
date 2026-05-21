addi  x2,  x0,   0     # x2 = 0x00000000, I2C status purposes
################################################# read one byte
lui   x3   1
addi  x3   x3    -1707 # x3 = 0x00000955, where:
# 0x55 - slave address = 0b1010101
# 0x1 - number of bytes to send
# 0x1 - R/W bit - read from slave
sw    x3,  32(x0)      # Send address, number of bytes to send and R/W bit to I2C controller
sw    x1,  40(x0)      # Read data by I2C
