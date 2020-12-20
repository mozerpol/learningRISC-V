### ORI
ORI
ANDI perform bitwise OR between register sign-extended 12-bit value. For example: `x2, x1, 0b101`. It means logical OR between *x1* register and *0b101* value. As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way. 

| ![ori1](https://user-images.githubusercontent.com/43972902/102725489-64d63200-4317-11eb-8ee5-2102077862f5.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [20.12.2020] |

| ![andi2](https://user-images.githubusercontent.com/43972902/102528734-3a7a3f80-409f-11eb-8efe-54fa799ae0b3.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 13*  [20.12.2020] |

**0 - 6:** 0010011 - It's *opcode*

**7 - 11:**  *rd* - it's destination register, e.g. x3 register

**12 - 14:** *funct3* - for ORI it's 110

**15 - 19:** *rs1* - first argument, e.g. x1 register

**20 - 31:** *imm* - it's number what we want add together with *rs1* register and save in *rd* register. This register is 12 bits long, so we can load <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1">  size number. <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1"> is equal 4095 in dec and 0xFFF in hex. But very **important** thing, we can **load only numbers from -2048 to 2047**.

`ORI` is instruction from *OP-IMM* family. <br/>
If we run instruction `ori x1, x0, 0b10101010101` in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code 55506093. <br/>
55506093 means in binary: 10101010101 00000 110 00001 0010011. What does it mean:
- First seven bits is our opcode: 0010011. Exacly the same like in manual :)
- Next five bits is our *rd*: 00001. 00001 in hex means 1, 1 like x1 register, it's our destination register :)
- Next three bits mean *func3* and in this case is 110, like in manual.
- Next five bits is *rs1*: 00000, like x0 register.
- Next is eleven bits are number what we want to multiply: 10101010101, in hex it is 1365.

Ok, the range of value in this instruction is from -2048 to 2047. <br/> Second... do you remember, that *ANDI* instruction works on three LSB? *ORI* working on all bits. What I mean? <br/> `0b00000000 00000000 00000000 00000000 <-- 32 bits`. We know, that 32 bits in binary is equal eight numbers in hex: <br/> `0x0000 0000 <-- eight positions in hex = 32 bits`. The `ORI` instruction operates on all bits: 0x00000000, but remember about value constraint, you can't do sth like: `ori x1, x0, 2049`. Ok, but how exactly does this instruction work? I think it's easy. I'll exmplain it on one example:
```
ori	    x1, x0, 0b11001110011
ori 	x2, x1, 0b10101010101
```
Logical OR between `0b11001110011` and `0b10101010101`:
```
0b11001110011 <-- 0x673
0b10101010101 <-- 0x555
-------------- ≥1
0b11101110111 <-- 0x777
```
*1* ≥1 *1* = *1* <br/>
*1* ≥1 *0* = *1* <br/>
*0* ≥1 *1* = *1* <br/>
*0* ≥1 *0* = *0* <br/>
There is a nice method for copying value frome one to other register:
`ori    rd, rs, 0` <br/>
*rd* - our destination <br/>
*rs* - frome where copy the value <br/>
This instruction is described on page 13 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).
