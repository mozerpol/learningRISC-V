### ADD
This instruction allows add two registers together and save the result in the third one. For example: `ADD x3, x1, x2`. It means add together x1 and x2 and save the result in x3.
As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way.
| ![add2](https://user-images.githubusercontent.com/43972902/102023344-815cf200-3d8c-11eb-8f11-42d9d20eff70.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [13.12.2020] |

| ![add1](https://user-images.githubusercontent.com/43972902/102023314-6db18b80-3d8c-11eb-9883-370b06563461.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 15*  [13.12.2020] |

**0 - 6:** 0110011 - It's *opcode*

**7 - 11:**  *rd* - it's destination register, e.g. x3 register

**12 - 14:** *funct3* - for ADD it's 000

**15 - 19:** *rs1* - first argument, e.g. x1 register

**20 - 24:** *rs2* - second argument, e.g. x2 register

**25 - 31:** *funct7* - in this case is 0000000 (seven zeros)

`ADD` is instruction from *OP* family. In this family the differences between commands are in *funct3* and *funct7*. The *opcode* is exacly the same. In this type RISC-V we have 32 general purpose registers, for this reason the *rd*, *rs1* and *rs2* have 5 bits long. Why? because src="https://render.githubusercontent.com/render/math?math=2^{5}"> is equal 32 :) So thanks to five bits we can address 32 registers.
If we run instruction `ADD x3, x1, x2` in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code 002081b3.  002081b3 means in binary: 0000000 00010 00001 000 00011 0110011. What does it mean:
- First seven bits is our opcode: 0110011. Exacly the same like in manual :)
- Next five bits is our *rd*: 00011. 00011 in hex means 3, 3 like x3 register, it's our destination register :)
- Next three bits mean *func3* and in this case is 000, like in manual.
- Next five bits is *rs1*: 00001, like x1 register.
- Next is five bits for second argument in this command - *rs2*: 00010, in hex it is 2, like x2 register.
- Next seven bits is for *funct7* and it's: 0000000, exactly like in manual.

This instruction is described on page 15 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).
