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

![lbuins](https://user-images.githubusercontent.com/43972902/113752787-a72c4f00-970d-11eb-85ff-6217ddf50176.png)
