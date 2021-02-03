### BNEZ
**BNEZ** - branch is not equal zero. It's pseudoinstruction. This instruction compares register with *x0* register, if they are different, then jump to the label. For example: `bnez 	x1, isNotEqualZero` will be translate to `bne x1, x0, isNotEqualZero`, where *isNotEqualZero* is our label. `bnez x1, isNotEqualZero` means: if *x1* is **not equal** *0* then jump to label *isNotEqualZero*. <br/>
All branch instructions use the B-type instruction format. As each instruction consists of 32 bits. Below I posted the pseudoinstruction and the corresponding basic instruction. 
| ![bnez1](https://user-images.githubusercontent.com/43972902/106786355-c0057f00-664e-11eb-81cb-c81710be4f92.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 110*  [03.01.2021] |

How the instruction works will be easiest to explain on example. Let's assume such an example: 
``` assembly
addi x1, x0, 0
isNotEqualZero:
	addi x1, x0, 1
	bnez x1, isNotEqualZero
```
And this instruction will be translated into: 
``` assembly
addi x1, x0, 0
isNotEqualZero:
	addi x1, x0, 1
	bne x1, x0, isNotEqualZero
```
