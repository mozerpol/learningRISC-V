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
If we run instruction `ori x1, x0, 0b10101010101` in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code 55506093. 

55506093 means in binary: 