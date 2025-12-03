################################################################################
##                                                                            ##
##                       BEQ, BNE, BLT, BGE, BLTU, BGEU                       ##
##                                                                            ##
################################################################################
########################################
##          Prepare registers         ##
########################################
addi  x1,  x0,   1     # x1 = 0x00000001
addi  x2,  x0,   2     # x2 = 0x00000002
addi  x3,  x0,   -1    # x3 = 0xffffffff
addi  x4,  x0,   0xff  # x4 = 0x000000ff
addi  x5,  x0,   4     # x5 = 0x00000004
addi  x7,  x0,   -4    # x7 = 0xfffffffc
addi  x8,  x0,   -8    # x8 = 0xfffffff8
addi  x9,  x0,   0     # x9 = 0x00000000
########################################
##                 BEQ                ##
########################################
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
########################################
##                 BNE                ##
########################################
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
########################################
##                 BLT                ##
########################################
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
########################################
##                 BGE                ##
########################################
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
########################################
##                BLTU                ##
########################################
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
########################################
##                BGEU                ##
########################################
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
