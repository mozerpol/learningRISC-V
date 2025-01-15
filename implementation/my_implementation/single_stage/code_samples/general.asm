# The machine code for these instructions below is in the file general.hex

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

########################################################
##                                                    ##
##  ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND  ##
##                                                    ##
########################################################
##############
##   ADD    ##
##############
add   x30, x0,   x28   # x30 = 0xffffffff
add   x31, x0,   x27   # x31 = 0x001fffff
add   x1,  x0,   x26   # x1 = 0x0000007f
add   x2,  x0,   x25   # x2 = 0x001fffff
add   x3,  x0,   x24   # x3 = 0x00000fff
add   x4,  x0,   x16   # x4 = 0x80000000
add   x5,  x0,   x0    # x5 = 0x00000000
add   x30, x5,   x30   # x30 = 0xffffffff
add   x31, x30,  x5    # x31 = 0xffffffff
add   x1,  x3,   x27   # x1 = 0x00200ffe
add   x2,  x2,   x28   # x2 = 0x001ffffe
add   x3,  x1,   x29   # x3 = 0x00200ffd
add   x4,  x31,  x26   # x4 = 0x0000007e
add   x5,  x30,  x25   # x5 = 0x001ffffe
add   x5,  x5,   x5    # x5 = 0x003ffffc
add   x5,  x5,   x5    # x5 = 0x007ffff8
##############
##   SUB    ##
##############
sub   x6,  x0,   x28   # x30 = 0x00000001
sub   x7,  x0,   x27   # x31 = 0xffe00001
sub   x8,  x0,   x26   # x1 = 0xffffff81
sub   x9,  x0,   x25   # x2 = 0xffe00001
sub   x10, x0,   x24   # x3 = 0xfffff001
sub   x11, x0,   x16   # x4 = 0x80000000
sub   x12, x0,   x0    # x5 = 0x00000000
sub   x6,  x15,  x6    # x6 = 0xfffffbff
sub   x7,  x16,  x5    # x7 = 0x7f800008
sub   x8,  x13,  x28   # x8 = 0x00000fff
sub   x9,  x12,  x27   # x9 = 0xffe00001
sub   x10, x10,  x26   # x10 = 0xffffef82
sub   x11, x31,  x25   # x11 = 0xffe00000
sub   x12, x30,  x24   # x12 = 0xfffff000
sub   x12, x12,  x12   # x12 = 0x00000000
sub   x12, x12,  x12   # x12 = 0x00000000
##############
##   SLL    ##
##############
sll   x13, x28,  x0    # x13 = 0xffffffff
sll   x14, x27,  x0    # x14 = 0x001fffff
sll   x15, x26,  x0    # x15 = 0x0000007f
sll   x16, x25,  x0    # x16 = 0x001fffff
sll   x17, x24,  x0    # x17 = 0x00000fff
sll   x18, x16,  x0    # x18 = 0x001fffff
sll   x19, x0,   x0    # x19 = 0x00000000
sll   x13, x15,  x6    # x13 = 0x80000000
sll   x14, x16,  x5    # x14 = 0xff000000
sll   x15, x13,  x28   # x15 = 0x00000000
sll   x16, x12,  x27   # x16 = 0x00000000
sll   x17, x10,  x26   # x17 = 0x00000000
sll   x18, x31,  x25   # x18 = 0x80000000
sll   x19, x30,  x24   # x19 = 0x80000000
sll   x19, x19,  x19   # x19 = 0x80000000
sll   x19, x19,  x19   # x19 = 0x80000000
##############
##   SLT    ##
##############
slt   x20, x28,  x0    # x20 = 0x00000001
slt   x21, x27,  x0    # x21 = 0x00000000
slt   x22, x26,  x0    # x22 = 0x00000000
slt   x23, x25,  x0    # x23 = 0x00000000
slt   x24, x24,  x0    # x24 = 0x00000000
slt   x25, x16,  x0    # x25 = 0x00000000
slt   x26, x0,   x0    # x26 = 0x00000000
slt   x20, x15,  x6    # x20 = 0x00000000
slt   x21, x16,  x5    # x21 = 0x00000001
slt   x22, x13,  x28   # x22 = 0x00000001
slt   x23, x12,  x27   # x23 = 0x00000001
slt   x24, x10,  x26   # x24 = 0x00000001
slt   x25, x31,  x25   # x25 = 0x00000001
slt   x26, x30,  x24   # x26 = 0x00000001
slt   x20, x20,  x20   # x20 = 0x00000000
slt   x20, x20,  x20   # x20 = 0x00000000
##############
##   SLTU   ##
##############
sltu  x27, x1,   x0    # x27 = 0x00000000
sltu  x28, x2,   x0    # x28 = 0x00000000
sltu  x29, x3,   x0    # x29 = 0x00000000
sltu  x30, x4,   x0    # x30 = 0x00000000
sltu  x31, x5,   x0    # x31 = 0x00000000
sltu  x1,  x6,   x0    # x1 = 0x00000000
sltu  x2,  x0,   x0    # x2 = 0x00000000
sltu  x27, x1,   x6    # x27 = 0x00000001
sltu  x28, x2,   x5    # x28 = 0x00000001
sltu  x29, x3,   x28   # x29 = 0x00000000
sltu  x30, x4,   x27   # x30 = 0x00000000
sltu  x31, x5,   x26   # x31 = 0x00000000
sltu  x1,  x6,   x25   # x1 = 0x00000000
sltu  x2,  x7,   x24   # x2 = 0x00000000
sltu  x2,  x2,   x2    # x2 = 0x00000000
sltu  x2,  x2,   x2    # x2 = 0x00000000
##############
##   XOR    ##
##############
xor   x3,  x10,  x11   # x3 = 0x001fef82
xor   x4,  x11,  x10   # x4 = 0x001fef82
xor   x5,  x14,  x8    # x5 = 0xff000fff
xor   x6,  x7,   x14   # x6 = 0x80800008
xor   x7,  x5,   x8    # x7 = 0xff000000
xor   x8,  x6,   x0    # x8 = 0x80800008
xor   x9,  x0,   x0    # x9 = 0x00000000
xor   x3,  x6,   x6    # x3 = 0x00000000
xor   x4,  x5,   x11   # x4 = 0x00e00fff
xor   x5,  x7,   x10   # x5 = 0x00ffef82
xor   x6,  x11,  x8    # x6 = 0x7f600008
xor   x7,  x14,  x14   # x7 = 0x00000000
xor   x8,  x10,  x13   # x8 = 0x7fffef82
xor   x9,  x5,   x3    # x9 = 0x00ffef82
xor   x9,  x9,   x9    # x9 = 0x00000000
xor   x9,  x9,   x9    # x9 = 0x00000000
##############
##   SRL    ##
##############
srl   x10, x10,  x11   # x10 = 0xffffef82
srl   x11, x11,  x10   # x11 = 0x3ff80000
srl   x12, x14,  x8    # x12 = 0x3fc00000
srl   x13, x7,   x14   # x13 = 0x00000000
srl   x14, x5,   x8    # x14 = 0x003ffbe0
srl   x15, x6,   x0    # x15 = 0x7f600008
srl   x16, x0,   x0    # x16 = 0x00000000
srl   x10, x10,  x6    # x10 = 0x00ffffef
srl   x11, x11,  x11   # x11 = 0x3ff80000
srl   x12, x2,   x10   # x12 = 0x00000000
srl   x13, x13,  x8    # x13 = 0x00000000
srl   x14, x14,  x14   # x14 = 0x003ffbe0
srl   x15, x15,  x13   # x15 = 0x7f600008
srl   x16, x16,  x3    # x16 = 0x00000000
srl   x16, x16,  x16   # x16 = 0x00000000
srl   x16, x16,  x16   # x16 = 0x00000000
##############
##   SRA    ##
##############
sra   x17, x4,   x6    # x17 = 0x0000e00f
sra   x18, x6,   x4    # x18 = 0x00000000
sra   x19, x6,   x8    # x19 = 0x1fd80002
sra   x20, x7,   x9    # x20 = 0x00000000
sra   x21, x8,   x19   # x21 = 0x1ffffbe0
sra   x22, x9,   x5    # x22 = 0x00000000
sra   x23, x10,  x0    # x23 = 0x00ffffef
sra   x17, x6,   x5    # x17 = 0x1fd80002
sra   x18, x7,   x11   # x18 = 0x00000000
sra   x19, x8,   x10   # x19 = 0x0000ffff
sra   x20, x9,   x8    # x20 = 0x00000000
sra   x21, x14,  x14   # x21 = 0x003ffbe0
sra   x22, x15,  x13   # x22 = 0x7f600008
sra   x23, x16,  x3    # x23 = 0x00000000
sra   x23, x23,  x23   # x23 = 0x00000000
sra   x23, x23,  x23   # x23 = 0x00000000
##############
##    OR    ##
##############
or    x24, x4,   x8    # x24 = 0x7fffefff
or    x25, x8,   x4    # x25 = 0x7fffefff
or    x26, x6,   x0    # x26 = 0x7f600008
or    x27, x7,   x10   # x27 = 0x00ffffef
or    x28, x8,   x19   # x28 = 0x7fffffff
or    x29, x10,  x5    # x29 = 0x00ffffef
or    x30, x11,  x0    # x30 = 0x3ff80000
or    x24, x6,   x5    # x24 = 0x7fffef8a
or    x25, x7,   x11   # x25 = 0x3ff80000
or    x26, x8,   x10   # x26 = 0x7fffffef
or    x27, x10,  x8    # x27 = 0x7fffffef
or    x28, x11,  x14   # x28 = 0x3ffffbe0
or    x29, x16,  x13   # x29 = 0x00000000
or    x30, x15,  x5    # x30 = 0x7fffef8a
or    x30, x30,  x30   # x30 = 0x7fffef8a
or    x30, x30,  x30   # x30 = 0x7fffef8a
##############
##   AND    ##
##############
and   x31, x4,   x6    # x31 = 0x00600008
and   x1,  x6,   x4    # x1 = 0x00600008
and   x2,  x6,   x8    # x2 = 0x7f600000
and   x3,  x10,  x9    # x3 = 0x00000000
and   x4,  x8,   x19   # x4 = 0x0000ef82
and   x5,  x11,  x5    # x5 = 0x00f80000
and   x31, x10,  x0    # x31 = 0x00000000
and   x1,  x6,   x5    # x1 = 0x00600000
and   x2,  x7,   x11   # x2 = 0x00000000
and   x3,  x8,   x10   # x3 = 0x00ffef82
and   x4,  x5,   x8    # x4 = 0x00f80000
and   x5,  x14,  x14   # x5 = 0x003ffbe0
and   x6,  x16,  x13   # x6 = 0x00000000
and   x7,  x15,  x4    # x7 = 0x00600000
and   x7,  x7,   x7    # x7 = 0x00600000
and   x7,  x7,   x7    # x7 = 0x00600000

########################################################
##                                                    ##
##                     LUI, AUIPC                     ##
##                                                    ##
########################################################
##############
##  AUIPC   ##
##############
auipc x8,  0           # x8 = ...
auipc x9,  0           # x9 = ...
sub   x10, x9,   x8    # x10 = 0x00000004
auipc x11, 0           # x11 = ..
auipc x12, 1048575     # x12 = ..
sub   x13, x12,  x11   # x13 = 0xfffff004
auipc x14, 0           # x14 = ...
auipc x15, 2048        # x15 = ...
sub   x16, x15, x14    # x16 = 0x00800004
auipc x17, 0           # x17 = ...
auipc x18, 1           # x18 = ...
sub   x19, x18, x17    # x19 = 0x00001004
##############
##   LUI    ##
##############
lui   x16, 0           # x16 = 0x00000000
lui   x17, 1048575     # x17 = 0xfffff000
lui   x18, 524287      # x18 = 0x7ffff000
lui   x19, 1024        # x19 = 0x00400000
lui   x20, 512         # x20 = 0x00200000
lui   x20, 512         # x20 = 0x00200000
lui   x21, 1           # x21 = 0x00001000

########################################################
##                                                    ##
##           BEQ, BNE, BLT, BGE, BLTU, BGEU           ##
##                                                    ##
########################################################
addi  x1,  x0,   1     # x1 = 0x00000001
addi  x2,  x0,   2     # x2 = 0x00000002
addi  x3,  x0,   -1    # x3 = 0xffffffff
addi  x4,  x0,   0xff  # x4 = 0x000000ff
addi  x5,  x0,   4     # x5 = 0x00000004
addi  x7,  x0,   -4    # x7 = 0xfffffffc
addi  x8,  x0,   -8    # x8 = 0xfffffff8
addi  x9,  x0,   0     # x9 = 0x00000000
##############
##   BEQ    ##
##############
loop1:
addi  x0,  x0,   0     # x0 = 0x00000000 1.
beq   x3,  x4,   loop1 # ... 2.
# The next instructions will check the correctness of this instruction
auipc x10, 0           # ... 3.
beq   x0,  x9,   loop2 # ... 4.
addi  x1,  x1,   1     # don't check, will never be done
loop4:
auipc x13, 0           # ... 8.
sub   x14, x13,  x11   # x14 = 0xffffffe8 9.
beq   x5,  x7,   loop6 # ... 10.
auipc x15, 0           # ... 11.
sub   x16, x15,  x13   # x16 = 0x0000000c 12.
beq   x9,  x0,   loop6 # ... 13.
loop2:
auipc x11, 0           # ... 5.
sub   x12, x11,  x10   # x12 = 0x00000024 6.
beq   x0,  x9,   loop4 # ... 7.
loop6:
auipc x17, 0           # ... 14.
sub   x18, x17,  x15   # x18 = 0x00000018 15.
addi  x1,  x1,   1     # x1 = 0x00000002 16.
addi  x1,  x0,   0     # x1 = 0x00000000 17.
##############
##   BNE    ##
##############
auipc x19, 0           # ... 1.
bne   x3,  x4,   loop7 # ... 2.
loop8:
auipc x22, 0           # ... 6.
sub   x23, x22,  x20   # x23 = 0xffffffe4 7.
addi  x1,  x1,   1     # x1 = 0x00000001 8.
bne   x9,  x0,   loop9 # ... 9.
auipc x24, 0           # ... 10.
sub   x25, x24,  x22   # x25 = 0x00000010 11.
bne   x7,  x8,   loop9 # ... 12.
loop7:
auipc x20, 0           # ... 3.
sub   x21, x20,  x19   # x21 = 0x00000024 4.
bne   x5,  x7,   loop8 # ... 5.
loop9:
auipc x26, 0           # ... 13.
sub   x27, x26,  x24   # x27 = 0x00000018 14.
addi  x1,  x0,   0     # x1 = 0x00000000 15.
##############
##   BLT    ##
##############
auipc x28, 0           # ... 1.
blt   x3,  x4,   loop10# ... 2.
loop11:
auipc x31, 0           # ... 10.
sub   x10, x31,  x28   # x10 = 0x00000008 11.
blt   x7,  x8,   loop12# ... 12.
addi  x1,  x1,   1     # x1 = 0x00000003 13.
blt   x3,  x1,   loop12# ... 14.
loop10:
auipc x29, 0           # ... 3.
sub   x30, x29,  x28   # x30 = 0x0000001c 4.
blt   x4,  x3,   loop11# ... 5.
addi  x1,  x1,   1     # x1 = 0x00000001 6.
blt   x9,  x0,   loop11# ... 7.
addi  x1,  x1,   1     # x1 = 0x00000002 8.
blt   x8,  x7,   loop11# ... 9.
loop12:
auipc x11, 0           # ... 15.
sub   x12, x11,  x31   # x12 = 0x00000030 16.
addi  x1,  x0,   0     # x1 = 0x00000000 17.
##############
##   BGE    ##
##############
auipc x13, 0           # ... 1.
bge   x4,  x3,   loop13# ... 2.
loop14:
auipc x16, 0           # ... 10.
sub   x17, x16,  x14   # x17 = 0x000000c8 11.
bge   x8,  x7,   loop15# ... 12.
addi  x1,  x1,   1     # x1 = 0x00000003 13.
bge   x1,  x3,   loop15# ... 14.
loop13:
auipc x14, 0           # ... 3.
sub   x15, x14,  x13   # x15 = 0x0000001c 4.
bge   x3,  x4,   loop14# ... 5.
addi  x1,  x1,   1     # x1 = 0x00000001 6.
bge   x7,  x4,   loop14# ... 7.
addi  x1,  x1,   1     # x1 = 0x00000002 8.
bge   x0,  x9,   loop14# ... 9.
loop15:
auipc x18, 0           # ... 15.
sub   x12, x18,  x16   # x12 = 0x00000030 16.
addi  x1,  x0,   0     # x1 = 0x00000000 17.
##############
##   BLTU   ##
##############
auipc x20, 0           # ... 1.
bltu  x8,  x7,   loop16# ... 2.
loop17:
auipc x23, 0           # ... = 6.
sub   x24, x23,  x21   # x24 = 0xffffffe4 7.
bltu  x9,  x0,   loop18# ... 8.
addi  x1,  x1,   1     # x1 = 0x00000001 9.
bltu  x3,  x4,   loop18# ... 10.
addi  x1,  x1,   1     # x1 = 0x00000002 11.
bltu  x4,  x3,   loop18# ... 12.
loop16:
auipc x21, 0           # ... = 3.
sub   x22, x21,  x20   # x22 = 0x00000024 4.
bltu  x8,  x7,   loop17# ... 5.
loop18:
auipc x25, 0           # ...  13.
sub   x26, x25,  x23   # x26 = 0x00000028 14.
addi  x1,  x0,   0     # x1 = 0x00000000 15.
##############
##   BGEU   ##
##############
auipc x27, 0           # ... 1.
bgeu  x7,  x8,   loop19# ... 2.
loop20:
auipc x28, 0           # ... = 6.
sub   x29, x28,  x27   # x29 = 0x00000100 7.
bgeu  x2,  x7,   loop21# ... 8.
addi  x1,  x1,   1     # x1 = 0x00000001 9.
bgeu  x4,  x3,   loop21# ... 10.
addi  x1,  x1,   1     # x1 = 0x00000002 11.
bgeu  x3,  x4,   loop21# ... 12.
loop19:
auipc x30, 0           # ... = 3.
sub   x31, x30,  x27   # x31 = 0x00000024 4.
bgeu  x7,  x8,   loop20# ... 5.
loop21:
auipc x10,  0          # ...  13.
sub   x11, x10,  x30   # x11 = 0x0000000c 14.
addi  x1,  x0,   0     # x1 = 0x00000000 15.

########################################################
##                                                    ##
##                     JAL, JALR                      ##
##                                                    ##
########################################################
##############
##   JAL    ##
##############
auipc x12,  0          # ... 1.
jal   x13,  loop22     # ... 2.
loop23:
addi  x1,  x1,   1     # x1 = 0x00000001 6.
addi  x1,  x1,   1     # x1 = 0x00000002 7.
jal   x15,  loop24     # ... 8.
loop22:
addi  x1,  x1,   1     # x1 = 0x00000001 3.
addi  x1,  x1,   1     # x1 = 0x00000004 4.
jal   x14,  loop23     # ... 5.
loop24:
addi  x1,  x1,   1     # x1 = 0x00000005 9.
auipc x16, 0           # ...  10.
sub   x17, x16,  x15   # x17 = 0x00000010 11.
addi  x1,  x0,   0     # x1 = 0x00000000 12.
##############
##   JALR   ##
##############
auipc x18, 0           # ... 1.
jalr  x19, x18,  8     # ... 2.
addi  x0,  x0,   0     # x0 = 0x00000000 3.
jalr  x20, x18,  28    # ... 4.
addi  x0,  x0,   0     # x0 = 0x00000000 7.
auipc x23, 0           # ... 8.
jalr  x24, x23,  16    # ... 9.
auipc x21, 0           # ... 5.
jalr  x22, x21,  -12   # ... 6.
addi  x0,  x0,   0     # x9 = 0x00000000 10.
addi  x0,  x0,   0     # x9 = 0x00000000 11.

########################################################
##                                                    ##
##                     SB, SH, SW                     ##
##                                                    ##
########################################################
addi  x1,  x0,   1     # x1 = 0x00000001
addi  x2,  x0,   2     # x2 = 0x00000002
addi  x3,  x0,   0     # x3 = 0x00000000
addi  x4,  x0,   1234  # x4 = 0x000004d2
addi  x5,  x0,   0xAB  # x5 = 0x000000ab
addi  x6,  x0,   0xCD  # x6 = 0x000000cd
addi  x7,  x0,   -1024 # x7 = 0xfffffc00
lui   x8,  0xABCDE     # x8 = 0xabcde000
addi  x8,  x8,   0xF1  # x8 = 0xabcde0f1
lui   x9,  0x12345     # x9 = 0x12345000
addi  x9,  x9,   0x678 # x9 = 0x12345678
##############
##    SB    ##
##############
sb    x9,  0(x0)       # 0x00000000 = 0x00000078
sb    x9,  1(x0)       # 0x00000000 = 0x00007878
sb    x9,  1(x1)   	   # 0x00000000 = 0x00787878
sb    x9,  1(x2)   	   # 0x00000000 = 0x78787878
sb    x9,  2(x2)   	   # 0x00000004 = 0x00000078
sb    x8,  -1(x1)  	   # 0x00000000 = 0x787878f1
sb    x8,  -1(x2)  	   # 0x00000000 = 0x7878f1f1
sb    x8,  -2(x2)  	   # 0x00000000 = 0x7878f1f1
sb    x8,  10(x0)  	   # 0x00000008 = 0x00f10000
sb    x8,  16(x1)  	   # 0x00000010 = 0x0000f100
##############
##    SH    ##
##############
sh    x8,  0(x0)  	   # 0x00000000 = 0xf1e07878
sh    x8,  1(x1)  	   # 0x00000000 = 0xf1e0f1e0
sh    x8,  2(x2)  	   # 0x00000004 = 0xf1e010e0
sh    x9,  -1(x1)  	   # 0x00000000 = 0x7856f1e0
sh    x8,  -2(x2) 	   # 0x00000000 = 0xf1e0f1e0
sh    x8,  10(x0) 	   # 0x00000008 = 0x9301f1e0
sh    x8,  16(x2) 	   # 0x00000010 = 0x93f1f1e0
##############
##    SW    ##
##############
sw    x7,  0(x0)       # 0x00000000 = 0x00fcffff
sw    x7,  2(x2)       # 0x00000004 = 0x00fcffff
sw    x8,  -1(x1)      # 0x00000000 = 0xf1e0cdab
sw    x7,  -2(x2)      # 0x00000000 = 0x00fcffff

########################################################
##                                                    ##
##                LB, LH, LW, LBU, LHU                ##
##                                                    ##
########################################################
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
addi  x1,  x0,   1     # x1 = 0x00000001
lbu   x2,  1(x0)       # x2  = 0x000000fc
lbu   x3,  1(x1)       # x3  = 0x000000ff
##############
##   LHU    ##
##############
lhu   x4,  4(x0)       # x4  = 0x0000fc00
lhu   x5,  1(x1)       # x5  = 0x0000ffff

########################################################
##                                                    ##
##                        GPIO                        ##
##                                                    ##
########################################################
addi  x1,  x0,   1     # x1 = 0x00000001
addi  x2,  x0,   2     # x2 = 0x00000002
addi  x3,  x0,   4     # x3 = 0x00000004
addi  x4,  x0,   8     # x4 = 0x00000008
addi  x5,  x0,   0xf   # x5 = 0x0000000f
addi  x6,  x0,   251   # x6 = 0x000000fb
addi  x7,  x0,   0x1f  # x7 = 0x0000001f
addi  x8,  x0,   0x2f  # x8 = 0x0000002f
addi  x9,  x0,   0x4f  # x9 = 0x0000004f
addi  x10, x0,   0x8f  # x10 = 0x0000008f
addi  x11, x0,   0xff  # x11 = 0x000000ff
addi  x12, x0,   129   # x12 = 0x00000081
addi  x13, x0,   24    # x13 = 0x00000018
addi  x14, x0,   153   # x14 = 0x00000099

sb    x0,  255(x0)     # gpio = 00000000
sb    x1,  255(x0)     # gpio = 00000001
sb    x2,  4(x6)       # gpio = 00000010
sb    x3,  255(x0)     # gpio = 00000100
sb    x4,  255(x0)     # gpio = 00001000
sb    x5,  255(x0)     # gpio = 00001111
sb    x7,  255(x0)     # gpio = 00011111
sb    x8,  255(x0)     # gpio = 00101111
sb    x9,  255(x0)     # gpio = 01001111
sb    x10, 255(x0)     # gpio = 10001111
sb    x11, 255(x0)     # gpio = 11111111
sb    x12, 255(x0)     # gpio = 10000001
sb    x13, 255(x0)     # gpio = 00011000
sb    x14, 255(x0)     # gpio = 10011001
sb    x0,  255(x0)     # gpio = 00000000

###################################
##       Check the GPIOs         ##
###################################
addi  x1,  x0,   0     # The value x1 is assigned to the GPIO output
addi  x2,  x0,   15    # The value x1 is compared to the value of x2. 15 = 1111
addi  x3,  x0,   0     # The value of x3 is compared to the value of x4, this
                       # works as a delay loop. The x3 is incremented if is not
                       # equal x4
addi  x4,  x0,   10    # x4 = 10, in reality this value as a delay is too small
loop26:
addi  x1,  x1,   1
sb    x1,  255(x0)     # Assign the value of x1 to GPIO
loop25:
addi  x3,  x3,   1     # Delay loop
bne   x3,  x4,   loop25# Is there enough delay? No: go to loop25
addi  x3,  x0,   0     # Yes: reset delay counter
bne   x1,  x2,   loop26# Were all the GPIOs on? No: go to loop26. Yes: all the
                       # GPIOs were turn on, reset all counters
addi  x1,  x0,   0
addi  x3,  x0,   0
sb    x0,  255(x0)     # Turn off GPIOs

addi  x2,  x0,   15     # Simulate GPIO output
addi  x3,  x0,   1
# Wait until input GPIO = 0, the lw command loads the value from GPIO into x1,
# and the bne command compares x1 with x0. Inside loop27 there must be an
# assignment gpio_tb(0) = 1
loop27:
lw    x1,  255(x0)
# gpio_tb(0) <= '1';
beq   x1,  x0    loop27

# Set high state on three output GPIOs
sb    x2,  255(x0)

###################################
##      Check Counter8bit        ##
###################################
addi  x1,  x0,   2     # Delay purposes, short loop
addi  x2,  x0,   0x212 # Delay purposes, long loop
addi  x3,  x0,   1     # 1 = turn on the timer, 0 = turn off and reset the timer
addi  x4,  x0,   0     # The value of x4 is compared to the value of x1, this
                       # works as a delay loop.
# Check the timer for one clock cycle
sb    x3,  251(x0)     # 1 = turn on the timer
sb    x0,  251(x0)     # 0 = turn off the timer
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
# Check the timer for two clock cycles
sb    x3,  251(x0)     # 1 = turn on the timer
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
sb    x0,  251(x0)     # 0 = turn off the timer
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
# Check the timer for 212 clock cycles
sb    x3,  251(x0)     # 1 = turn on the timer
loop28:
addi  x4,  x4,   1     # Long delay loop
bne   x4,  x2,   loop28# Is there enough delay?
sb    x0,  251(x0)     # 0 = turn off the timer
addi  x4,  x0,   0     # Reset delay loop
# Read the counter value and save it in the x5 register
sb    x3,  251(x0)     # 1 = turn on the timer
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
addi  x0,  x0,   0     # nop
lw    x5,  251(x0)     # Read the counter value and save it in the x5 register
sb    x0,  251(x0)     # 0 = turn off the timer

###################################
##         Check UART tx         ##
###################################
lui   x1,  0x2
addi  x1,  x1,   0x1FC # Delay purposes, x1 = 8700, 0x21FC
addi  x2,  x0,   0     # Loop purposes, index
lui   x4,  0x41505     # Load upper 20 bits
ori   x4,  x4,   0x544 # Load lower 12 bits, x4 = 0x41505544, ascii = DUPA
addi  x5,  x0,   0xD   # New line sign
sw    x4,  247(x0)     # Send data by UART from x4 reg, ascii = DUPA
loop29:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop29# Is there enough delay? No: go to loop29
addi  x2,  x0,   0     # Reset x2
nop
nop
nop
sw    x5,  247(x0)     # Send data by UART, a new line sign
loop30:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop30# Is there enough delay? No: go to loop30
addi  x2,  x0,   0     # Reset x2

###################################
##         Check UART rx         ##
###################################
lui   x1,  0x1
addi  x1,  x1,   -1926 # Delay purposes, x1 = 2170, 0x87a
addi  x2,  x0,   0
loop31:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop31# Is there enough delay? No: go to loop31
addi  x2,  x0,   0     # Reset counter
lw    x10, 247(x0)     # Save incoming data on UART in x10 reg

###################################
##   Check four 7seg displays    ##
###################################
addi  x1,  x0,   0
addi  x2,  x0,   1
addi  x3,  x0,   9
addi  x4,  x0,   10
addi  x5,  x0,   91
addi  x6,  x0,   100
addi  x7,  x0,   910
addi  x8,  x0,   991
addi  x9,  x0,   999
lui   x10, 2
addi  x10, x10,  1684
sw    x1,  243(x0)     # Display 0
sw    x2,  243(x0)     # Display 1
sw    x3,  243(x0)     # Display 9
sw    x4,  243(x0)     # Display 10
sw    x5,  243(x0)
sw    x6,  243(x0)
sw    x7,  243(x0)
sw    x8,  243(x0)
sw    x9,  243(x0)
sw    x10, 243(x0)

###################################
##         Check SPI tx          ##
###################################
addi  x1,  x1,   789   # Delay purposes, x1 = 789, 0x315
addi  x2,  x0,   0
addi  x3,  x0,   0xff
lui   x4,  699051
addi  x4,  x4,   -1366 # x4 = 0x AAAAAAAA
sw    x3,  239(x0)     # Send the value stored in the register x3
loop32:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop32# Is there enough delay? No: go to loop32
addi  x2,  x0,   0
sw    x4,  239(x0)     # Send the value stored in the register x4
loop33:
addi  x2,  x2,   1     # Increment x2
bne   x1,  x2,   loop33# Is there enough delay? No: go to loop32
addi  x2,  x0,   0
