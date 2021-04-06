### LBU
**LBU** - load unsigned byte. It's **not** pseudoinstruction. The easiest way to explain how it works will be an example. Imagine this code:
``` assembly
la 	x1, array
lbu x2, 0(x1)
lbu x3, 1(x1)
.data
array:
	.asciiz "AB"
```



In brief:
| Line number: | Instruction: | Short description |
|:--:|:--:|:--:|
| 1. | `la 	x1, array` | Load *PC* adress array label to *x1* register |
| 2. | `lbu x2, 0(x1)` | Read first byte from label saved in *x1* and save result in *x2* |
| 3. | `lbu x3, 1(x1)` | Read second byte from label saved in *x1* and save result in *x2* |
| 4. | `.data` | Assembly directive |
| 5. | `array:` |  |
| 6. | `.asciiz "AB"` | Save *"AB"* string in memory |
