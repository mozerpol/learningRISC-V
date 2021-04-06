### LBU
**LBU** - load unsigned byte. It's **not** pseudoinstruction. The easiest way to explain how it works will be an example. Imagine this code:
``` assembly
la 	x1, array
lbu x2, 0(x1)
.data
array:
	.asciiz "ABC"
```
[LA](https://github.com/mozerpol/learningRISC-V/tree/main/instructions/LA) instrucion will save in *x1* register the value of *PC*, where locate is label *array*. So... *LA* instruction saved in *x1* register the value of *PC*, which point to our *array* label. Whereas (pol. *natomiast*) **LBU** will save in *x2* register first bit what *x1* register indicates. Ok once again, but using different words... <br/>
`LBU x2, 0(x1)` 
- *x2* - save here the result of the *LBU* instruction 
- *0* - save first byte in *x2*. 1 will means save second byte in register, 2 will save third...
- *x1* - take first byte (because 0) from adress which is in *x1*.

In brief:
| Line number: | Instruction: | Short description |
|:--:|:--:|:--:|
| 1. | `la 	x1, array` | Load *PC* adress array label to *x1* register |
| 2. | `lbu x2, 0(x1)` | Read first byte from label saved in *x1* and save result in *x2* |
| 3. | `.data` | Assembly directive |
| 4. | `array:` |  |
| 5. | `.asciiz "ABC"` | Save *"ABC"* string in memory |

This instruction is mentioned on page 19 and 104 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).

As each instruction consists of 32 bits. Below I posted photo of the frame that describes what the bits do.
| ![lbuins](https://user-images.githubusercontent.com/43972902/113752787-a72c4f00-970d-11eb-85ff-6217ddf50176.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 14*  [06.04.2021] |

- **0 - 6**: *0000011* - It’s opcode 
- **7 - 11**: *rd* - it’s destination, e.g. x2 register like in our example
- **12 - 14**: *100* - funct3 which is 100
- **15 - 19**: *rs1* - argument, e.g. x1 register
- **20 - 31**: *imm[11:0]* - which byte we want take. In our example we want fetch first byte (because we have 0). It's very important - the range of this instruction is from 0 to 11 bits it means 2^12 = 4096, **but** the real range is from -2048 to 2047. It means we can take byte from -2048 position up to 2047.
