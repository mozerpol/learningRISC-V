################################################################################
##                                                                            ##
##                                    SPI                                     ##
##                                                                            ##
################################################################################
########################################
##                TX                  ##
########################################
addi  x1,  x0,   1     # x1 = 0x00000001, turn on sclk 
addi  x1,  x1,   2     # x1 = 0x00000011, chip enable
addi  x2,  x0,   0     # x2 = 0x00000000
addi  x3,  x0,   0xAA  # x3 = 0x000000AA, data1 to send
lui   x4,  703711      # x4 = 0xabcdef00, data2 to send
addi  x4,  x4,   -238  # x4 = 0xabcdef12, data2 to send

sw    x1,  227(x0)     # Turn on sclk and chip enable

sw    x3,  235(x0)     # Send data1 by SPI
loop35:
lw    x2,  231(x0)     # Load SPI status bit to x2 register
bne   x2,  x0,   loop35# Check if uart tx is busy

sw    x4,  235(x0)     # Send data2 by SPI
loop36:
lw    x2,  231(x0)     # Load SPI status bit to x2 register
bne   x2,  x0,   loop36# Check if uart tx is busy

sw    x0,  227(x0)     # Turn off sclk and chip enable
addi  x1,  x0,   0
addi  x1,  x1,   1
addi  x1,  x1,   1
addi  x1,  x1,   1
addi  x1,  x1,   1
########################################
##                RX                  ##
########################################
