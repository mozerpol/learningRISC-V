################################################################################
##                                                                            ##
##                                   I2C RX                                   ##
##                                                                            ##
################################################################################
lui   x1,  0xF0E7C     # x1 = 0xF0E7C000, data to send
addi  x1,  x1,   0x381 # x1 = 0xF0E7C381 = 11110000 11100111 11000011 10000001
addi  x2,  x0,   0     # x2 = 0x00000000, I2C status purposes
###################################
##         Read one byte         ##
###################################
lui   x3,  1
addi  x3,  x3,   -1707 # x3 = 0x00000955, where:
# 0x55 - slave address = 0b1010101
# 0x1 - number of bytes to send
# 0x1 - R/W bit - read from slave
sw    x3,  32(x0)      # Send address, number of bytes to send and R/W bit to I2C controller
loop41:
lw    x2,  44(x0)      # Load I2C status
andi  x2,  x2    0x1   # Check the oldest bit (no. 0)
bne   x2,  x0,   loop41# Check if I2C rx is busy, when = 1, then jump to loop41
addi  x4,  x0,   0x1   # x4 = 0x00000001
addi  x4,  x4,   0x1   # x4 = 0x00000002
addi  x4,  x4,   0x1   # x4 = 0x00000003
###################################
##         Read two bytes        ##
###################################
lui   x3,  1
addi  x3,  x3,   -1451 # x3 = 0x00000A55, where:
# 0x55 - slave address = 0b1010101
# 0x2 - number of bytes to send
# 0x1 - R/W bit - read from slave
sw    x3,  32(x0)      # Send address, number of bytes to send and R/W bit to I2C controller
loop42:
lw    x2,  44(x0)      # Load I2C status
andi  x2,  x2    0x1   # Check the oldest bit (no. 0)
bne   x2,  x0,   loop42# Check if I2C rx is busy, when = 1, then jump to loop42
addi  x4,  x4,   0x1   # x4 = 0x00000004
addi  x4,  x4,   0x1   # x4 = 0x00000005
addi  x4,  x4,   0x1   # x4 = 0x00000006
###################################
##        Read three bytes       ##
###################################
lui   x3,  1
addi  x3,  x3,   -1195 # x3 = 0x00000B55, where:
# 0x55 - slave address = 0b1010101
# 0x3 - number of bytes to send
# 0x1 - R/W bit - read from slave
sw    x3,  32(x0)      # Send address, number of bytes to send and R/W bit to I2C controller
loop43:
lw    x2,  44(x0)      # Load I2C status
andi  x2,  x2    0x1   # Check the oldest bit (no. 0)
bne   x2,  x0,   loop43# Check if I2C rx is busy, when = 1, then jump to loop43
addi  x4,  x4,   0x1   # x4 = 0x00000007
addi  x4,  x4,   0x1   # x4 = 0x00000008
addi  x4,  x4,   0x1   # x4 = 0x00000009
###################################
##        Read four bytes        ##
###################################
lui   x3,  1
addi  x3,  x3,   -964  # x3 = 0x00000C3C, where:
# 0x3C - slave address = 0b0111100
# 0x4 - number of bytes to send
# 0x1 - R/W bit - read from slave
sw    x3,  32(x0)      # Send address, number of bytes to send and R/W bit to I2C controller
loop44:
lw    x2,  44(x0)      # Load I2C status
andi  x2,  x2    0x1   # Check the oldest bit (no. 0)
bne   x2,  x0,   loop44# Check if I2C rx is busy, when = 1, then jump to loop44
addi  x4,  x4,   0x1   # x4 = 0x0000000A
addi  x4,  x4,   0x1   # x4 = 0x0000000B
addi  x4,  x4,   0x1   # x4 = 0x0000000C
