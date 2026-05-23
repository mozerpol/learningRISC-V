################################################################################
##                                                                            ##
##                                   I2C RX                                   ##
##                                                                            ##
################################################################################
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
sw    x1,  40(x0)      # Start reading data by I2C
loop41:
lw    x2,  44(x0)      # Load I2C status
andi  x2,  x2    0x1   # Check the oldest bit (no. 0)
bne   x2,  x0,   loop41# Check if I2C rx is busy, when = 1, then jump to loop37

addi  x4,  x0,   0x1   # x4 = 0x00000001
addi  x4,  x4,   0x1   # x4 = 0x00000002
addi  x4,  x4,   0x1   # x4 = 0x00000003
