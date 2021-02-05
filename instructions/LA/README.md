### LA
**LA** - load adress. `LA` is a pseudoinstruction. The definition this instruction from manual is: `la rd, label`. **LA** is translated into two instructions: 
```assembly
auipc rd symbol[31:12]
addi rd rd symbol[11:0]
```
Where: <br/>
- *rd* - register destination, where we want to save the result of the instruction, e.g. x1 or other  registry.
- *label* - it's the label we want to save to the register *rd*.  
These two instructions above mean:
1. `auipc rd label` - save in *rd* register value of the PC registry where the instruction `auipc` appears. It means. If `auipc rd label` will appear in 

I think that the easiest way to understand how the instruction works will be an example:
```assembly
addi	x2, x0, 0
la 		x1, numb
addi	x2, x0, 0
numb:
	addi	x2, x0, 0
```
