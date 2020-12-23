### SLTIU
Set Less Than Immediate Unsigned<br/>
*STLIU* is almost the same like [SLTI](https://github.com/mozerpol/learningRISC-V/tree/main/instructions/SLTI). The diffrence is only that *SLTIU* can compare absolute value from unsigned number, not only signed like in *SLTI*. <br/>
SLTIU compares value from *imm* register to value in *rs1* register. If value from *imm* is greater than value from *rs1*, then save number *1* in *rd* register. The range of value, which can be compared is is from abs(-2048) to 2047. <br/>
As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way. 

| ![sltiu1](https://user-images.githubusercontent.com/43972902/103022760-ea8ef300-454c-11eb-8daf-f9e98f5f3897.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [23.12.2020] |

| ![slti2](https://user-images.githubusercontent.com/43972902/102727844-9f949600-4328-11eb-9172-3e0911e5b037.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 13*  [23.12.2020] |

**0 - 6:** 0010011 - It's *opcode*

**7 - 11:**  *rd* - it's destination register, e.g. x3 register

**12 - 14:** *funct3* - for SLTIU it's 010

**15 - 19:** *rs1* - first argument, e.g. x1 register

**20 - 31:** *imm* - it's number what we want compare with *rs1* register and save in *rd* register. This register is 12 bits long, so we can load <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1">  size number. <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1"> is equal 4095 in dec and 0xFFF in hex. But very **important** thing, we can **load only numbers from -2048 to 2047**.

`SLTIU` is instruction from *OP-IMM* family. <br/>
If we run instruction `sltiu x2, x1, -2048` in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code 8000b113. <br/>
8000b113 means in binary: 100000000000 00001 011 00010 0010011. What does it mean:
- First seven bits is our opcode: 0010011. Exacly the same like in manual :)
- Next five bits is our *rd*: 00010. 00010 in hex means 2, 2 like x2 register, it's our destination register :)
- Next three bits mean *func3* and in this case is 010, like in manual.
- Next five bits is *rs1*: 00001, like x1 register.
- Next is eleven bits are number what we want to compare: 100000000000, in dec it is -2048.
The range of value in this instruction is from -2048 to 2047. <br/> 
This instruction is described on page 13 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).
