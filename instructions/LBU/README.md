### LBU
**LBU** - load unsigned byte. It's **not** pseudoinstruction. The easiest way to explain how it works will be an example. Imagine this code:
``` assembly
la 	x1, array
lbu x2, 0(x1)
.data
array:
	.asciiz "ABC"
```
[LA](https://github.com/mozerpol/learningRISC-V/tree/main/instructions/LA) instrucion will save in *x1* register the value of *PC*, where locate is label *array*. So... *LA* instruction saved in *x1* register the value of *PC*, which point to our *array* label. Whereas (pol. *natomiast*) **LBU** will save in *x2* register first bit what *x1* register indicates.


In brief:
| Line number: | Instruction: | Short description |
|:--:|:--:|:--:|
| 1. | `la 	x1, array` | Load *PC* adress array label to *x1* register |
| 2. | `lbu x2, 0(x1)` | Read first byte from label saved in *x1* and save result in *x2* |
| 3. | `.data` | Assembly directive |
| 4. | `array:` |  |
| 5. | `.asciiz "ABC"` | Save *"ABC"* string in memory |
