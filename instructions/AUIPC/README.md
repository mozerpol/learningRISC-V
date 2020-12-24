### AUIPC
*AUIPC* - Add Upper Immediate to PC. <br/>
Thanks to this instruction we can save in any register program counter status and 20bits new adress. <br/>
This instruction is described on page 14 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf). 
As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way.
| ![auipc1](https://user-images.githubusercontent.com/43972902/103107554-c6600e80-463f-11eb-86b7-eb917b86ba3d.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [13.12.2020] |

| ![auipc2](https://user-images.githubusercontent.com/43972902/103107560-d677ee00-463f-11eb-97e2-045229275d22.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 14*  [13.12.2020] |

**0 - 6:** 0110111 - It's *opcode* <br/>
**7 - 11:**  *rd* - it's destination, e.g. x1 register <br/>
**12 - 31:** *imm* - it's number what we want load. This register is 20 bits long, so we can load <img src="https://render.githubusercontent.com/render/math?math=2^{20}-1">  size number. <img src="https://render.githubusercontent.com/render/math?math=2^{20}-1"> is equal 1048575 in dec and 0xFFFFF in hex.

If we run instruction `auipc x5, 0xfffff` in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code fffff297. fffff297 means in binary: 11111111111111111111 00101 0010111. What does it mean:
- First seven bits is our opcode: 0110111. Exacly the same like in manual :)
- Next five bits is our destination: 00101. 00101 like `x5` register :)
- The rest of the bits (20 bits): 11111111111111111111. This numbers means our number, which we want load to x5 register. If we translate 11111111111111111111 to hex we will get 0xFFFFF :)
