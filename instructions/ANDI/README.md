### ANDI
ANDI perform bitwise AND between register sign-extended 12-bit value. For example: `x2, x1, 0b101`. It means logical AND between *x1* register and *0b101* value. As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way. 

| ![andi1](https://user-images.githubusercontent.com/43972902/102528666-233b5200-409f-11eb-8dc3-89e4a9ba29a3.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [13.12.2020] |

| ![andi2](https://user-images.githubusercontent.com/43972902/102528734-3a7a3f80-409f-11eb-8efe-54fa799ae0b3.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 13*  [13.12.2020] |

**0 - 6:** 0010011 - It's *opcode*

**7 - 11:**  *rd* - it's destination register, e.g. x3 register

**12 - 14:** *funct3* - for ADDI it's 000

**15 - 19:** *rs1* - first argument, e.g. x1 register

**20 - 31:** *imm* - it's number what we want add together with *rs1* register and save in *rd* register. This register is 12 bits long, so we can load <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1">  size number. <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1"> is equal 4095 in dec and 0xFFF in hex. But very **important** thing, we can **load only numbers from -2048 to 2047**.

`ANDI` is instruction from *OP-IMM* family. <br/>
If we run instruction `andi x1, x0, 0b10101010101` in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code 55507093.  55507093 means in binary: 10101010101 00000 111 00001 0010011. What does it mean:
- First seven bits is our opcode: 0010011. Exacly the same like in manual :)
- Next five bits is our *rd*: 00001. 00001 in hex means 1, 1 like x1 register, it's our destination register :)
- Next three bits mean *func3* and in this case is 111, like in manual.
- Next five bits is *rs1*: 00000, like x0 register.
- Next is eleven bits are number what we want to multiply: 10101010101, in hex it is 1365.
Ok, but how exactly does this instruction work? I think it's easy. I'll exmplain it on one example:
```
addi	x1, x0, 0b11001110011
andi 	x2, x1, 0b10101010101
```
First important info, the range of value in this instruction is from -2048 to 2047, so we only have three LSB. What I mean? In this type of RISC-V we have 32 general purpose registers: x0, x1, ..., x31. Each register has 32 bits: <br/>
`0b00000000 00000000 00000000 00000000 <-- 32 bits`. We know, that 32 bits in binary is equal eight numbers in hex: <br/> `0x0000 0000 <-- eight positions in hex = 32 bits`. The `ANDI` instruction operates only on three LSB (first three places from right), it's mean `ANDI` can only perform AND bitwise on first three bits: 0x~~00000~~ 000. Ok, but back to the example:
```
addi	x1, x0, 0b11001110011
andi 	x2, x1, 0b10101010101
```
Logical AND between `0b11001110011` and `0b10101010101`:
```
0b11001110011 <-- 0x673
0b10101010101 <-- 0x555
-------------- &
0b10001010001 <-- 0x451
```
*1* & *1* = *1* <br/>
*1* & *0* = *0* <br/>
*0* & *1* = *0* <br/>
*0* & *0* = *0* <br/>
This instruction is described on page 13 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).
