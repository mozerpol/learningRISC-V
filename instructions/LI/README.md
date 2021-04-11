### LI
**LI** - load immediate. *LI* is a pseudoinstruction. The operation of this instruction is very simple. *LI* will save at *LSB* (least significant bit) result of adding our argument and *0* number. The instruction:
```assembly
li		x2, 3
```

will change to:
```assembly
addi    x2, x0, 3
```

So our code means: save in *x2* register result of adding *x0* reg and *3* number, which is our argument. In this case *LI* instruction will save in *x2* reg *3* number on LSB:
``` 
    0x00000000      <-- x0 register
    0x00000003      <-- 3 number in hex representation
---------------- +  <-- add x0 and 3
    0x00000003      <-- result saved in x2 register
```

The range of *LI* instruction is 


`LUI` was described [here](https://github.com/mozerpol/learningRISC-V/tree/main/instructions/LUI).
This instruction is described on page 110 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).

