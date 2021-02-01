### JALR
**JALR** - jump and link register. <br/>
JALR perform jump to the selected adress from register and transferred value. I think that the easiest way to understand how the instruction works will be an example:
``` assembly
addi	x2, x0, 0
addi	x2, x0, 0
addi	x2, x0, 2
jalr	x1, x2, 2
```
First thing is understand how [program counter](https://github.com/mozerpol/learningRISC-V#pc) works and what is it. In brief *PC* is a register that indicates which instruction should be executed. Every information about this takes 4 bits in *PC*. In our example we have three instructions `addi` and jump instruction `jalr`. So in *program counter* we have four numbers, because we have four instructions. Ok, in other words:
| Line number: | Instruction: | Program counter status [hex]: |
|:--:|:--:|:--:|
| 1. | `addi x2, x0, 0` | 4 |
| 2. | `addi x2, x0, 0` | 8 |
| 3. | `addi x2, x0, 2` | c |
| 4. | `jalr x1, x2, 2` | 10 |

If we execute line number 1 the program counter have value 4, if we execute line number 2 the program counter have value 8, if we execute line number 3 the program counter have value c, etc. `jalr` says to write actual value of *PC*, from where we jump to some register and jump somewhere. In this example `jalr` will save to *x1* value *0x10*, because *PC* in this line (nr. 4) have *0x10* value and jump to somewhere. Also is very important to understand how the jump is executed. <br/>
Let's assume this instruction: `jalr x1, x2, 4`. This instruction means:
- save status *PC* in *x1*
- jump to instruction number: (*x2* + *0x4*). E.g if *x2* is equal 0x4, so then jump to instruction number: 0x4 + 0x4 = 0x8. Every insruction has own number in PC register. In our table we can see four instructions and four PC addresses. If `jalr` has 0x4 + 0x4 = 0x8 it means jump to instruction number 0x8.

*Jalr* consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way. 

| ![jalr2](https://user-images.githubusercontent.com/43972902/106524720-41d89980-64e3-11eb-883a-ed026be81d0a.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [01.02.2021] |

| ![jalr1](https://user-images.githubusercontent.com/43972902/106525687-a7795580-64e4-11eb-8fd0-44aeecc67213.png) |
|:--:|100010011
| Source: *RISC-V Instruction Set Manual v2.2, p 16*  [01.02.2021]|

**0 - 6:** 1101111 - It's *opcode*

**7 - 11:** *rd* - it's destination register, e.g. x4 register

**12 - 14** *funct3* - for jalr is 000

**15 - 19** *rs1* - first argument, e.g. x1 register

**20 - 31:** *imm* - it's number what we want add together with *rs1* register and save in *rd* register. This register is 12 bits long, so we can load <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1">  size number. <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1"> is equal 4095 in dec and 0xFFF in hex.

If we run instruction: 
``` assembly
addi	x2, x0, 0
addi	x2, x0, 0
addi	x2, x0, 2
jalr	x1, x2, 2
```
in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code:
```
00000113
00000113
00200113
002100e7
```                       
*00000113* means in binary: *000000000000 00000 000 00010 0010011* and it's our `addi` instruction. *002100e7* is also `addi` instruction, but with different argument.<br/>
*002100e7* is our `jalr` and means in binary: *000000000010 00010 000 00001 1100111*.

This instruction is described on page 16 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).
