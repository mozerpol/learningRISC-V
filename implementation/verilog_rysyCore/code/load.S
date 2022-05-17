start:
la x1, array

loop:
lbu x2, 0(x1)
addi x1, x1, 1
bnez x2, loop

j start

.data
array:
.asciiz "Ala ma kota!"
