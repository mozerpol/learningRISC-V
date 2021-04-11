### LI
**LI** - load immediate. *LI* is a pseudoinstruction. The operation of this instruction is very simple. *LI* will save at *LSB* (least significant bit) result of adding our argument and *0* number. The instruction:
```assembly
li		x2, 3
```
will change to:
```assembly
addi    x2, x0, 3
```
