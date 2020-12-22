### JAL
**JAL** - jump and link. <br/>
JAL perform jump to the selected adress and save in chosen register how many steps you want to go back. I think that the easiest way to understand how the instruction works will be an example:
``` assembly
loop:
    addi 	x5, x5, 1
    addi 	x5, x5, 1
jal 	x4, loop
```
First thing is understand how [program counter](https://github.com/mozerpol/learningRISC-V#pc) works and what is it. In brief *PC* is a register that indicates which instruction should be executed. Every information about this takes 4 bits in PC. In our example we have label called: `loop`, two instructions `addi` and jump instruction `jal`. So in *program counter* we have three informations, because we have three instructions (label doesn't count [?]). Ok, in other words:
| Line number: | Instruction: | Program counter status [hex]: |
|:--:|:--:|:--:|
| 1. | `loop:` | 0 |
| 2. | `addi x5, x5, 1` | 4 |
| 3. | `addi x5, x5, 1` | 8 |
| 4. | `jal x4, loop` | c |

If we execute line number 1 the program counter have value 0, if we execute line number 2 the program counter have value 4, if we execute line number 3 the program counter have value 8, etc. `jal` says to write actual value of *PC*, from where we jump to some register and jump somewhere. In this example `jal` will save to *x4* value *0xc*, because *PC* in this line (nr. 4) have *0xc* value and jump to `loop` label. 

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
