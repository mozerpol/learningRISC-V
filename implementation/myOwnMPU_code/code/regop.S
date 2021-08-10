lui     x1, 0x12345
addi    x1, x1, 0x678
andi    x2, x1, -1
ori     x3, x1, 0xf
slti    x4, x0, -1
sltiu   x5, x0, -1
add     x3, x0, x2
end:
j end
