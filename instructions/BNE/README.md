### BNE
**BNE** - branch not equal. This instruction compares the contents of two registers, if they are different, then jump to the label. For example: `bne x2, x1, loop` means, if *x2* and *x1* are different, then jump to the *loop* label. <br/>
All branch instructions use the B-type instruction format. As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way.
| ![bne2](https://user-images.githubusercontent.com/43972902/106637664-494f7f80-6583-11eb-8265-1af39b592d5d.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png* [02.01.2021]|

| ![bne1](https://user-images.githubusercontent.com/43972902/106637482-08f00180-6583-11eb-9af5-a13dfff56210.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 17*  [02.01.2021] |

**0 - 6:** 1100011 - It's *opcode*

**7 - 8:** *imm* - 

**9 - 11:** *imm* - 

**12 - 14:** *func3* - for BNE it's 001

**15 - 19:** *rs1* - first argument, e.g. x1 register

**20 - 24:** *rs2* - second argument, e.g. x2 register

**25 - 30:** *imm* - 

**31 - 32:** *imm* - 

How the instruction works will be easiest to explain on example. Let's assume such an example: 
``` assembly
addi	x1, x0, 0
addi	x2, x0, 0
loop:
	addi 	x1, x1, 2
	addi	x2, x2, 3
	bne		x2, x1, loop
```
If we translate it into machine code, we get: 
```
00000093
00000113
00208093
00310113
fe111ce3 
```
Ok, first four lines are `addi` instruction. The last one is `bne` instruction: `fe111ce3`, which means in binary: `1111111 00001 00010 001 11001 1100011`.
- *1111111* - *imm*, 127 in dec
- *00001* - *rs2*
- *00010* - *rs1*
- *001* - *funct3*
- *11001* - *imm*, 25 in dec
- *1100011* - *opcode*

**I DON'T KNOW HOW *IMM* PART WORKS**















