li   x1, 0x20000000
li   x2, 0
start:
li   x3, 5
loop:
addi x3, x3, -1
bnez x3, loop
addi x2, x2, 1
sw   x2, 0, x1
j    start