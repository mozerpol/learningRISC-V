start:
li      x1 3
la      x2 array

loop:
slli    x3 x1 2
add     x3 x2 x3
sw      x1 0(x3)
addi    x1 x1 -1
bnez    x1 loop

j start
array:
