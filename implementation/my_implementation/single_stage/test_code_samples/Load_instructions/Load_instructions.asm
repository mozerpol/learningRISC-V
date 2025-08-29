########################################################
##                                                    ##
##                LB, LH, LW, LBU, LHU                ##
##      This is a I-type instruction format;          ##
##  however, I decided to write the tests separately  ##
########################################################
########################################
##          Prepare registers         ##
########################################
addi  x1,  x0,   1     # x1 = 0x00000001
addi  x2,  x0,   2     # x2 = 0x00000002
addi  x3,  x0,   0     # x3 = 0x00000000
addi  x7,  x0,   -1024 # x7 = 0xfffffc00
lui   x8,  0xE         # x8 = 0x0000e000
addi  x8,  x8,   0xF1  # x8 = 0x0000e0f1
########################################
##           Prepare memory           ##
########################################
sw    x7,  0(x0)       # Load to address 0x00000000 4 bytes: 0x 00 fc ff ff 
sw    x7,  2(x2)       # Load to address 0x00000004 4 bytes: 0x 00 fc ff ff
sh    x8   10(x0)      # Load to address 0x00000008 2 bytes: 0x -- -- f1 e0
##############
##    LB    ##
##############
lb    x3,  0(x1)       # x3 = 0xfffffffc
lb    x4,  0(x2)       # x4 = 0xffffffff
lb    x5,  11(x0)      # x5 = 0xffffffe0
lb    x7,  -1(x2)      # x7 = 0xfffffffc
lb    x8,  -2(x2)      # x8 = 0x00000000
lb    x12, 4(x3)       # x12 = 0x00000000
lb    x13, 15(x3)      # x13 = 0xffffffe0
##############
##    LH    ##
##############
lh    x14, 0(x2)       # x14 = 0xffffffff
lh    x15, 10(x0)      # x15 = 0xffffe0f1
lh    x17, 4(x3)       # x17 = 0xfffffc00
##############
##    LW    ##
##############
lw    x18, 2(x2)       # x18 = 0xfffffc00
lw    x21, 4(x3)       # x21 = 0xfffffc00
##############
##   LBU    ##
##############
lbu   x2,  1(x0)       # x2  = 0x000000fc
lbu   x3,  1(x1)       # x3  = 0x000000ff
##############
##   LHU    ##
##############
lhu   x4,  4(x0)       # x4  = 0x0000fc00
lhu   x5,  1(x1)       # x5  = 0x0000ffff
