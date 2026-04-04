addi  x1,  x0,   0x0495# x1 = 0x00000495
# R/W bit: 0 - write to slave
# Number of bytes to send: 4
# Data to send: 0x95 = 0b10010101
addi  x2,  x0,   0x95  # x2 = 0x00000095, data. 0x95 = 0b10010101
sw    x1,  32(x0)      # Send address to I2c controller
sw    x2,  36(x0)      # Send data by I2C
