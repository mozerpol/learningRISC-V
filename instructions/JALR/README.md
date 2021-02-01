### JALR
**JALR** - jump and link register. <br/>
JALR perform jump to the selected adress from register and transferred value. I think that the easiest way to understand how the instruction works will be an example:
``` assembly
addi	x2, x0, 0
addi	x2, x0, 0
addi	x2, x0, 2
jalr	x1, x2, 2
```
First thing is understand how [program counter](https://github.com/mozerpol/learningRISC-V#pc) works and what is it. In brief *PC* is a register that indicates which instruction should be executed. Every information about this takes 4 bits in PC. In our example we three instructions `addi` and jump instruction `jalr`. So in *program counter* we have four informations, because we have three instructions. Ok, in other words:
| Line number: | Instruction: | Program counter status [hex]: |
|:--:|:--:|:--:|
| 1. | `addi x2, x0, 0` | 4 |
| 2. | `addi x2, x0, 0` | 8 |
| 3. | `addi x2, x0, 0` | c |
| 4. | `jalr x1, x2, 2` | 10 |

If we execute line number 1 the program counter have value 4, if we execute line number 2 the program counter have value 8, if we execute line number 3 the program counter have value c, etc. `jalr` says to write actual value of *PC*, from where we jump to some register and jump somewhere. In this example `jalr` will save to *x1* value *0x10*, because *PC* in this line (nr. 4) have *0x10* value and jump to somewhere. It's very important to understand how the jump is executed. Let's assume this instruction: `jalr x1, x2, 4`. This instruction means:
- save status *PC* in *x1*
- jump to value in (*x2* + *0x4*). E.g if *x2* is equal 0x4, so then 0x4 + 0x4 = 0x8, means jump back two instructions (one instruction is 0x4, so 0x8 = 2 instruciotns).

In our example save 0x10 value in x1 and jump back

*Jal* consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way. 

| ![jal1](https://user-images.githubusercontent.com/43972902/102912188-6457ab80-447d-11eb-8990-46b4e8883c90.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [22.12.2020] |

| ![jal2](https://user-images.githubusercontent.com/43972902/102912384-9c5eee80-447d-11eb-8f40-729f85fba598.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 13*  [22.12.2020] |

**0 - 6:** 1101111 - It's *opcode*

**7 - 11:** *rd* - it's destination register, e.g. x4 register

**12 - 31:** *imm* - it's always the same.

`JAL` is instruction from *J* family. <br/>
If we run instruction: 
``` assembly
loop:
    addi 	x5, x5, 1
    addi 	x5, x5, 1
jal 	x4, loop
```
in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code:
```
00128293
00128293
ff9ff26f
```
00128293 means in binary: *000000000001 00101 000 00101 0010011* and it's our `addi` instruction. <br/>
ff9ff26f means in binary: *11111111100111111111 00100 1101111* and it's our `jal` instruction.

This instruction is described on page 16 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).
