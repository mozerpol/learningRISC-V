### JAL
**JAL** - jump and link. <br/>
JAL perform jump to the selected adress and save in chosen register how many steps you want to go back. I think that the easiest way to understand how the instruction works will be an example:
``` assembly
loop:
    addi 	x5, x5, 1
    addi 	x5, x5, 1
jal 	x4, loop
```
First thing is understand how [program counter](https://github.com/mozerpol/learningRISC-V#pc) works and what is it. In brief *PC* is a register that indicates which instruction should be executed. Every information about this takes 4 bits in PC. If we have two *lui* instructions in *PC* we have two four bits informations about it. In our example we have label called: `loop`, two instructions `addi` and jump instruction `jal`. So in *program counter* we have three informations, because we have three instructions (label doesn't count [?]). Ok, in other words:
| Line number: | Instruction: | Program counter status [hex]: |
|:--:|:--:|:--:|
| 1. | `loop:` | 0 |
| 2. | `addi x5, x5, 1` | 4 |
| 3. | `addi x5, x5, 1` | 8 |
| 4. | `jal x4, loop` | c |

If we execute line number 1 the program counter have value 0, if we execute line number 2 the program counter have value 4, if we execute line number 2 the program counter have value 8, etc. `jal` says to write actual value of *PC*, from where we jump to some register. In this example `jal` will save in *x4* value *0xc*.
