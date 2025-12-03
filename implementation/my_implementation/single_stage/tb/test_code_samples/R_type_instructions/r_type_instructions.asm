################################################################################
##                                                                            ##
##              ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND              ##
##                                                                            ##
################################################################################
########################################
##         Prepare registers          ##
########################################
addi  x1,  x0,   0     # x1 = 0x00000000
addi  x2,  x0,   -1    # x2 = 0xffffffff
addi  x3,  x0,   -1    # x3 = 0xffffffff
addi  x4,  x0,   -1    # x4 = 0xffffffff
addi  x5,  x0,   -2048 # x5 = 0xfffff800
addi  x6,  x0,   0     # x6 = 0x00000000
addi  x7,  x0,   2046  # x7 = 0x000007fe
addi  x8,  x0,   0     # x8 = 0x00000000
addi  x9,  x0,   0     # x9 = 0x00000000
addi  x10, x0,   0     # x10 = 0x00000000
addi  x11, x0,   0     # x11 = 0x00000000
addi  x12, x0,   -511  # x12 = 0xfffffe01
addi  x13, x0,   0xff  # x13 = 0x000000ff
slli  x13, x13,  4     # x13 = 0x00000ff0
addi  x13, x13,  0xE   # x13 = 0x00000ffe
addi  x14, x0,   4     # x14 = 0x00000004
addi  x15, x0,   -1024 # x15 = 0xfffffc00
addi  x16, x0,   0x1   # x16 = 0x00000001
slli  x16, x16,  31    # x16 = 0x80000000
addi  x17, x0,   0     # x17 = 0x00000000
addi  x18, x0,   -2    # x18 = 0xfffffffe
addi  x19, x0,   0     # x19 = 0x00000000
addi  x19, x19,  -256  # x19 = 0xffffff00
addi  x20, x0,   511   # x20 = 0x000001ff
addi  x21, x0,   4     # x21 = 0x00000004
slli  x21, x21,  20    # x21 = 0x00400000    
addi  x21, x21,  -1    # x21 = 0x003fffff
addi  x22, x0,   1     # x22 = 0x00000001
slli  x22, x22,  12    # x22 = 0x00001000
addi  x22, x22,  -1	   # x22 = 0x00000fff
addi  x23, x0,   0	   # x23 = 0x00000000
addi  x24, x0,   1     # x24 = 0x00000001
slli  x24, x24,  12    # x24 = 0x00001000
addi  x24, x24,  -1	   # x24 = 0x00000fff
addi  x25, x0,   2     # x25 = 0x00000002
slli  x25, x25,  20    # x25 = 0x00200000
addi  x25, x25,  -1    # x25 = 0x001fffff
addi  x26, x0,   0x7f  # x26 = 0x0000007f
addi  x27, x0,   2     # x27 = 0x00000002
slli  x27, x27,  20    # x27 = 0x00200000
addi  x27, x27,  -1    # x27 = 0x001fffff
addi  x28, x0,   -1    # x28 = 0xffffffff
addi  x29, x0,   -1    # x29 = 0xffffffff
addi  x30, x0,   -1    # x30 = 0xffffffff
addi  x31, x0,   -1    # x31 = 0xffffffff
########################################
##                ADD                 ##
########################################
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
########################################
##                SUB                 ##
########################################
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
########################################
##                SLL                 ##
########################################
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
########################################
##                SLT                 ##
########################################
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
########################################
##                SLTU                ##
########################################
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
########################################
##                XOR                 ##
########################################
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
########################################
##                SRL                 ##
########################################
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
########################################
##                SRA                 ##
########################################
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
########################################
##                 OR                 ##
########################################
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
########################################
##                AND                 ##
########################################
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
