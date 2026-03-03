################################################################################
##                                                                            ##
##                                    SPI                                     ##
##                                                                            ##
################################################################################
########################################
##                TX                  ##
########################################
addi  x2,  x0,   0     # x2 = 0x00000000, to compare with SPI status register
addi  x3,  x0,   0x95  # x3 = 0x00000095, data to send. 0x95 = 0b10010101
sw    x3,  20(x0)      # Send data by SPI
loop35:
lw    x2,  28(x0)      # Load SPI status bit to x2 register
beq   x2,  x0,   loop35# Check if uart tx is busy
########################################
##                RX                  ##
########################################
addi  x1,  x0,   0     # x1 = 0x00000000
addi  x2,  x0,   0     # x2 = 0x00000000
sw    x0,  24(x0)      # Start SPI read data
loop36:
lw    x2,  28(x0)      # Load SPI status bit to x2 register
bne   x2,  x0,   loop36# Check if uart rx is busy
lw    x1,  24(x0)      # Load received data on SPI to x1 register
