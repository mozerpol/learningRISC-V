### LA
**LA** - load adress. `LA` is a pseudoinstruction. The definition this instruction from manual is: `la rd, symbol`. **LA** is translated into two instructions: 
```assembly
auipc rd symbol[31:12]
addi rd rd symbol[11:0]
```
Where: <br/>
- *rd* - register destination, where we want to save the result of the instruction, e.g. x1 or other  registry.
- *symbol* - it's the address of the label we want to save to the register *rd*. 
These two instructions above mean:
1. `auipc rd symbol[31:12]` - save on the five oldest bits in *rd* register the value. It means: if we have`auipc rd 0xfff`, it'll save in *rd* register *0x00fff000*.
2. `addi rd rd symbol[11:0]` - add to *rd* register value.

Ok, but maybe I'll try also using different words. <br/> 
I think that the easiest way to understand how the instruction works will be an example:
```assembly
addi	x2, x0, 0
la 		x1, numb
addi	x2, x0, 0
numb:
	addi	x2, x0, 0
```
First line reset *x2* register. Next `la x1, numb` is translated into: <br/>
```assembly
auipc x1 0
addi x1 x1 12
```
This two lines reset *x1* register and then add to *x1* register value *12*. Why *12*? Because our label *numb* has *12* value in PC register.
| Line number: | Instruction: | Program counter status [hex]: |
|:--:|:--:|:--:|
| 1. | `addi x2, x0, 0` | 4 |
| 2. | `la x1, numb` | 8 |
| 3. | `addi x2, x0, 0` | c |
| 4. | `numb:` | 10 |
| 5. | `addi x2, x0, 0` | 10 |
