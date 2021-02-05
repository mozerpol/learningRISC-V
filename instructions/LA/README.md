### LA
**LA** - load adress. `LA` is a pseudoinstruction. The definition this instruction from manual is: `la rd, label`. **LA** is translated into two instructions: 
```assembly
auipc rd label
addi rd rd label[11:0]
```
Where: <br/>
- *rd* - register destination, where we want to save the result of the instruction, e.g. x1 or other  registry.
- *label* - it's the label we want to save to the register *rd*.  
