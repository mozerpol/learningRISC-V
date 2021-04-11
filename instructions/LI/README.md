### LI
**LI** - load immediate. *LI* is a pseudoinstruction. It will save in register the argument. So far if we want save in register (e.g.) *x1* number *3* we do:
```assembly
addi x2, x0, 0x3
```

If we want save in register (e.g.) *x1* number *3000* we do:
```assembly
lui 	x1, 1
addi 	x1, x1, -1096
```

*LUI* will save in *x1* on fourth position (0x00001000) number *1*. *0x00001000* is equal 4096 so we must substract 1096. This calculation will do *ADDI* instruction. So once again, if we want save in *x1* register number 3000 at first:
1. Use *LUI* instruction. The smallest number which *LUI* can save is 4096 (0x00001000) 
2. Substract from *x1* 1096, because 4096 - 1096 = 3000

As we can see it's a little bit complicated and time-consuming, so someone thought about a pseudoinstruction, which will replace these calculations. As you can guess this instruction is *LI*. So once again, if we want save in *x1* 3000 numb we can use *LI*:
```assembly
li      x1, 3000
```

This instruction will be replace at:
```assembly
lui     x1, 1
addi    x1, x1, -1096
```

Thanks to this it's not needed calculate everything. So above code means:
```assembly
    0x00000000      <-- x1 register
    0x00000001      <-- 1 number in hex representation
---------------- +  <-- lui x1, 1
    0x00001000      <-- result of lui instruction
```

After these: 
```assembly
    0x00001000      <-- x1 register
    0x00000448      <-- -1096 number in hex representation
---------------- +  <-- addi    x1, x1, -1096
    0x00001000      <-- result of addi instruction
```

=======================


So our code means: save in *x2* register result of adding *x0* reg and *3* number, which is our argument. In this case *LI* instruction will save in *x2* reg *3* number on LSB:
```assembly
    0x00000000      <-- x0 register
    0x00000003      <-- 3 number in hex representation
---------------- +  <-- add x0 and 3
    0x00000003      <-- result saved in x2 register
```

The range of *LI* instruction is 


`LUI` was described [here](https://github.com/mozerpol/learningRISC-V/tree/main/instructions/LUI).
`ADDI` was described [here](https://github.com/mozerpol/learningRISC-V/tree/main/instructions/ADDI).
Instruction `LI` is described on page 110 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).

