addi	x1, x0, 0 # reset x1
addi	x2, x0, 0 # reset x2
ori		x1, x0, 0b11001110011 # 0b11001110011 = 1651 in dec = 0x673
ori 	x2, x1, 0b10101010101 # 0b10101010101 = 1365 in dec = 0x555
#----------------------------
# result: 0b11001110011 ≥1 0b10101010101 = 0b11101110111
# 0b11101110111 = 1911 in dec = 0x777
