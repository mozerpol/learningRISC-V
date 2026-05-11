lui   x1,  0xF0E7C     # x1 = 0xF0E7C000, data to send
addi  x1,  x1,   0x381 # x1 = 0xF0E7C381 = 11110000 11100111 11000011 10000001
addi  x2,  x0,   0     # x2 = 0x00000000, I2C status purposes

################################################# send one byte
addi  x3,  x0,   0x155 # x3 = 0x00000155, where:
# 0x55 - slave address = 0b1010101
# 0x1 - number of bytes to send
# 0x0 - R/W bit - write to slave
sw    x3,  32(x0)      # Send address, number of bytes to send and R/W bit to I2C controller
sw    x1,  36(x0)      # Send data by I2C
loop37:
lw    x2,  44(x0)      # Load I2C status
andi  x2,  x2    0x1   # Check the oldest bit (no. 0)
bne   x2,  x0,   loop37# Check if I2C tx is busy, when = 1, then jump to loop37

addi  x4,  x0,   0x1   # x4 = 0x00000001
addi  x4,  x4,   0x1   # x4 = 0x00000002
addi  x4,  x4,   0x1   # x4 = 0x00000003

################################################# send two bytes

addi  x3,  x0,   0x278 # x3 = 0x00000278, where:
# 0x78 - slave address = 0b1111000
# 0x2 - number of bytes to send
# 0x0 - R/W bit - write to slave

sw    x3,  32(x0)      # Send address, number of bytes to send and R/W bit to I2C controller
sw    x1,  36(x0)      # Send data by I2C
loop38:
lw    x2,  44(x0)      # Load I2C status
andi  x2,  x2    0x1   # Check the oldest bit (no. 0)
bne   x2,  x0,   loop38# Check if I2C tx is busy, when = 1, then jump to loop38

addi  x4,  x4,   0x1   # x4 = 0x00000004
addi  x4,  x4,   0x1   # x4 = 0x00000005
addi  x4,  x4,   0x1   # x4 = 0x00000006

################################################# send three bytes

addi  x3,  x0,   0x30F # x3 = 0x0000030F, where:
# 0x0F - slave address
# 0x3 - number of bytes to send
# 0x0 - R/W bit - write to slave

sw    x3,  32(x0)      # Send address, number of bytes to send and R/W bit to I2C controller
sw    x1,  36(x0)      # Send data by I2C
loop39:
lw    x2,  44(x0)      # Load I2C status
andi  x2,  x2    0x1   # Check the oldest bit (no. 0)
bne   x2,  x0,   loop39# Check if I2C tx is busy, when = 1, then jump to loop39

addi  x4,  x4,   0x1   # x4 = 0x00000007
addi  x4,  x4,   0x1   # x4 = 0x00000008
addi  x4,  x4,   0x1   # x4 = 0x00000009

################################################# send four bytes

addi  x3,  x0,   0x4FF # x1 = 0x000004FF, where:
# 0xFF - slave address
# 0x4 - number of bytes to send
# 0x0 - R/W bit - write to slave

sw    x3,  32(x0)      # Send address, number of bytes to send and R/W bit to I2C controller
sw    x1,  36(x0)      # Send data by I2C
loop40:
lw    x2,  44(x0)      # Load I2C status bit
andi  x2,  x2    0x1   # Check the oldest bit (no. 0)
bne   x2,  x0,   loop40# Check if I2C tx is busy, when = 1, then jump to loop40

addi  x4,  x4,   0x1   # x4 = 0x0000000a
addi  x4,  x4,   0x1   # x4 = 0x0000000b
addi  x4,  x4,   0x1   # x4 = 0x0000000c
