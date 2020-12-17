### ADDI
This instruction allows add number and register together and save result in register. For example: `addi x2, x1, 0x5`. It means add *0x5* number to *x1* register and save result in *x2* register. As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way.
| ![addi1](https://user-images.githubusercontent.com/43972902/102025580-32698980-3d99-11eb-9c07-55b1bddc380b.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [13.12.2020] |
| ![addi2](https://user-images.githubusercontent.com/43972902/102025595-5200b200-3d99-11eb-81fc-fd77af53dbcc.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 13*  [13.12.2020] |

**0 - 6:** 0010011 - It's *opcode*

**7 - 11:**  *rd* - it's destination register, e.g. x3 register

**12 - 14:** *funct3* - for ADDI it's 000

**15 - 19:** *rs1* - first argument, e.g. x1 register

**20 - 31:** *imm* - it's number what we want add together with *rs1* register and save in *rd* register. This register is 12 bits long, so we can load <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1">  size number. <img src="https://render.githubusercontent.com/render/math?math=2^{12}-1"> is equal 4095 in dec and 0xFFF in hex. But very **important** thing, we can **load only numbers from -2048 to 2047**.

`ADDI` is instruction from *OP-IMM* family.
If we run instruction `addi x2, x1, 0x5` in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code 00308113.  00308113 means in binary: 00011 00001 000 00010 0010011. What does it mean:
- First seven bits is our opcode: 0010011. Exacly the same like in manual :)
- Next five bits is our *rd*: 00010. 00010 in hex means 2, 2 like x2 register, it's our destination register :)
- Next three bits mean *func3* and in this case is 000, like in manual.
- Next five bits is *rs1*: 00001, like x1 register.
- Next is five bits it's number what we want add - *rs2*: 00011, in hex it is 5

Ok, but how exactly does this instruction work? It'll be the easiest explain on few examples, suppose `x1` and `x2` is equal zero at the beginning:
1. `addi x2, x1, 0x3` - add 0x3 number to x1 register: 
``` 
    0x00000000      <-- x1 register
    0x00000003      <-- 0x3 number
---------------- +  <-- add x1 and 0x3
    0x00000003      <-- result saved in x2 register
```
`addi` instruction saves the result in LSB.
2. `addi x2, x1, 2047` - add 2047 number to x1 register: 
``` 
    0x00000000      <-- x1 register
    0x000007FF      <-- 2047 number in hex representation
---------------- +  <-- add x1 and 2047
    0x000007FF      <-- result saved in x2 register
```
`addi` instruction is using [two's complement](https://github.com/mozerpol/learningRISC-V/blob/main/README.md#terms) to show the result. In this system of representation if you need negative number, you must replace *1* with *0* and add *1* to the finally result. Ok, but what I mean? Usually if we have number e.g. *0010* it is *2*, but in two's complement value *-2* looks: *1110*. In first step we replace *0* on *1* and *1* on *0*, so *0010* -> *1101* and then add to this number *1*. So the result is *1110*. Another example. Typically value *9* means *1001*. In first step we replace *0* on *1* and *1* on *0*, so *1001* -> *0110* and then add to this number *1*. So the result is *0111*.
3. `addi x2, x1, -0x3` - subtract 0x3 number to x1 register: 
``` 
    0x00000000      <-- x1 register
    0xfffffffd      <-- -3 number in hex representation
---------------- +  <-- subtract x1 and 0x3
    0x000007FF      <-- result saved in x2 register
```
Ok. *3* in binary is *0011*. If we need negative number, we must replace *1* with *0* and add *1* to the finally result. *0011* -> *1100* and add *1* -> *1101*.
Why `0xfffffffd` means *-3*? `0xfffffffd` in binary is `11111111111111111111111111111101`. Look at last three bits, it's our *-3*.
4. `addi x2, x1, -2048` - subtract 2048 number to x1 register: 
``` 
    0x00000000      <-- x1 register
    0xfffffffd      <-- -2048 number in hex representation
---------------- +  <-- subtract x1 and 2048
    0xfffff800      <-- result saved in x2 register
```

Instruction ADDI is used to implementation `MV` pseudo-instruction: `ADDI rd, rs, 0`. 

This instruction is described on page 15 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf).
