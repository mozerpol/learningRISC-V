##########################################################
##                                                      ##
## ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI ##
##                                                      ##
##########################################################
##############
##   ADDI   ##
##############
addi  x1,  x0,   -2048 # x1 = 0xfffff800
addi  x2,  x0,   -511  # x2 = 0xfffffe01
addi  x3,  x0,   -2    # x3 = 0xfffffffe
addi  x4,  x0,   0     # x4 = 0x00000000
addi  x5,  x0,   1     # x5 = 0x00000001
addi  x6,  x0,   511   # x6 = 0x000001ff
addi  x7,  x0,   2047  # x7 = 0x000007ff
addi  x1,  x7,   -2048 # x1 = 0xffffffff
addi  x2,  x6,   -511  # x2 = 0x00000000
addi  x3,  x5,   -2    # x3 = 0xffffffff
addi  x4,  x4,   0     # x4 = 0x00000000
addi  x5,  x3,   1     # x5 = 0x00000000
addi  x6,  x2,   511   # x6 = 0x000001ff
addi  x7,  x1,   2047  # x7 = 0x000007fe
addi  x1,  x1,   2047  # x1 = 0x000007fe
addi  x1,  x1,   -2048 # x1 = 0xfffffffe
##############
##   SLTI   ##
##############
slti  x8,  x0,   -2048 # x8 = 0x00000000
slti  x9,  x0,   -511  # x9 = 0x00000000
slti  x10, x0,   -2    # x10 = 0x00000000
slti  x11, x0,   0     # x11 = 0x00000000
slti  x12, x0,   1     # x12 = 0x00000001
slti  x13, x0,   511   # x13 = 0x00000001
slti  x14, x0,   2047  # x14 = 0x00000001
slti  x8,  x7,   -2048 # x8 = 0x00000000
slti  x9,  x1,   -511  # x9 = 0x00000000
slti  x10, x12,  -2    # x10 = 0x00000000
slti  x11, x11,  0     # x11 = 0x00000000
slti  x12, x10,  1     # x12 = 0x00000001
slti  x13, x6,   511   # x13 = 0x00000000
slti  x14, x9,   2047  # x14 = 0x00000001
slti  x14, x14,  2047  # x14 = 0x00000001
slti  x14, x14,  -2048 # x14 = 0x00000000
##############
##  SLTIU   ##
##############
sltiu x15, x0,   -2048 # x15 = 0x00000001
sltiu x16, x0,   -511  # x16 = 0x00000001
sltiu x17, x0,   -2    # x17 = 0x00000001
sltiu x18, x0,   0     # x18 = 0x00000000
sltiu x19, x0,   1     # x19 = 0x00000001
sltiu x20, x0,   511   # x20 = 0x00000001
sltiu x21, x0,   2047  # x21 = 0x00000001
sltiu x15, x7,   -2048 # x15 = 0x00000001
sltiu x16, x1,   -511  # x16 = 0x00000000
sltiu x17, x19,  -2    # x17 = 0x00000001
sltiu x18, x18,  0     # x18 = 0x00000000
sltiu x19, x17,  1     # x19 = 0x00000000
sltiu x20, x6,   511   # x20 = 0x00000000
sltiu x21, x15,  2047  # x21 = 0x00000001
sltiu x21, x21,  2047  # x21 = 0x00000001
sltiu x21, x21,  -2048 # x21 = 0x00000001
##############
##   XORI   ##
##############
xori  x22, x0,   -2048 # x22 = 0xfffff800
xori  x23, x0,   -511  # x23 = 0xfffffe01
xori  x24, x0,   -2    # x24 = 0xfffffffe
xori  x25, x0,   0     # x25 = 0x00000000
xori  x26, x0,   1     # x26 = 0x00000001
xori  x27, x0,   511   # x27 = 0x000001ff
xori  x28, x0,   2047  # x28 = 0x000007ff
xori  x22, x28,  -2048 # x22 = 0xffffffff
xori  x23, x27,  -511  # x23 = 0xfffffffe
xori  x24, x26,  -2    # x24 = 0xffffffff
xori  x25, x25,  0     # x25 = 0x00000000
xori  x26, x24,  1     # x26 = 0xfffffffe
xori  x27, x23,  511   # x27 = 0xfffffe01
xori  x28, x22,  2047  # x28 = 0xfffff800
xori  x28, x28,  2047  # x28 = 0xffffffff
xori  x28, x28,  -2048 # x28 = 0x000007ff
##############
##   ORI    ##
##############
ori   x29, x0,   -2048 # x29 = 0xfffff800
ori   x30, x0,   -511  # x30 = 0xfffffe01
ori   x31, x0,   -2    # x31 = 0xfffffffe
ori   x1,  x0,   0     # x1 = 0x00000000
ori   x2,  x0,   1     # x2 = 0x00000001
ori   x3,  x0,   511   # x3 = 0x000001ff
ori   x4,  x0,   2047  # x4 = 0x000007ff
ori   x29, x4,   -2048 # x29 = 0xffffffff
ori   x30, x3,   -511  # x30 = 0xffffffff
ori   x31, x2,   -2    # x31 = 0xffffffff
ori   x1,  x1,   0     # x1 = 0x00000000
ori   x2,  x31,  1     # x2 = 0xffffffff
ori   x3,  x30,  511   # x3 = 0xffffffff
ori   x4,  x28,  2047  # x4 = 0x000007ff
ori   x4,  x4,   2047  # x4 = 0x000007ff
ori   x4,  x4,   -2048 # x4 = 0xffffffff
##############
##   ANDI   ##
##############
andi  x5,  x0,   -2048 # x5 = 0x00000000
andi  x6,  x0,   -511  # x6 = 0x00000000
andi  x7,  x0,   -2    # x7 = 0x00000000
andi  x8,  x0,   0     # x8 = 0x00000000
andi  x9,  x0,   1     # x9 = 0x00000000
andi  x10, x0,   511   # x10 = 0x00000000
andi  x11, x0,   2047  # x11 = 0x00000000
andi  x5,  x4,   -2048 # x5 = 0xfffff800
andi  x6,  x10,  -511  # x6 = 0x00000000
andi  x7,  x28,  -2    # x7 = 0x000007fe
andi  x8,  x27,  0     # x8 = 0x00000000
andi  x9,  x7,   1     # x9 = 0x00000000
andi  x10, x6,   511   # x10 = 0x00000000
andi  x11, x5,   2047  # x11 = 0x00000000
andi  x11, x11,  2047  # x11 = 0x00000000
andi  x11, x11,  -2048 # x11 = 0x00000000
##############
##   SLLI   ##
##############
slli  x12, x0,   0     # x12 = 0x00000000
slli  x13, x0,   1     # x13 = 0x00000000
slli  x14, x0,   2     # x14 = 0x00000000
slli  x15, x0,   10    # x15 = 0x00000000
slli  x16, x0,   20    # x16 = 0x00000000
slli  x17, x0,   31    # x17 = 0x00000000
slli  x12, x27,  0     # x12 = 0xfffffe01
slli  x13, x28,  1     # x13 = 0x00000ffe
slli  x14, x21,  2     # x14 = 0x00000004
slli  x15, x29,  10    # x15 = 0xfffffc00
slli  x16, x5,   20    # x16 = 0x80000000
slli  x17, x7,   31    # x17 = 0x00000000
slli  x17, x17,  31    # x17 = 0x00000000
slli  x17, x17,  0     # x17 = 0x00000000
##############
##   SRLI   ##
##############
srli  x18, x0,   0     # x18 = 0x00000000
srli  x19, x0,   1     # x19 = 0x00000000
srli  x20, x0,   2     # x20 = 0x00000000
srli  x21, x0,   10    # x21 = 0x00000000
srli  x22, x0,   20    # x22 = 0x00000000
srli  x23, x0,   31    # x23 = 0x00000000
srli  x18, x26,  0     # x18 = 0xfffffffe
srli  x19, x27,  1     # x19 = 0x7fffff00
srli  x20, x28,  2     # x20 = 0x000001ff
srli  x21, x29,  10    # x21 = 0x003fffff
srli  x22, x30,  20    # x22 = 0x00000fff
srli  x23, x7,   31    # x23 = 0x00000000
srli  x23, x23,  31    # x23 = 0x00000000
srli  x23, x23,  0     # x23 = 0x00000000
##############
##   SRAI   ##
##############
srai  x24, x0,   0     # x24 = 0x00000000
srai  x25, x0,   1     # x25 = 0x00000000
srai  x26, x0,   2     # x26 = 0x00000000
srai  x27, x0,   10    # x27 = 0x00000000
srai  x28, x0,   20    # x28 = 0x00000000
srai  x29, x0,   31    # x29 = 0x00000000
srai  x24, x22,  0     # x24 = 0x00000fff
srai  x25, x21,  1     # x25 = 0x001fffff
srai  x26, x20,  2     # x26 = 0x0000007f
srai  x27, x19,  10    # x27 = 0x001fffff
srai  x28, x18,  20    # x28 = 0xffffffff
srai  x29, x16,  31    # x29 = 0xffffffff
srai  x29, x29,  31    # x29 = 0xffffffff
srai  x29, x29,  0     # x29 = 0xffffffff
