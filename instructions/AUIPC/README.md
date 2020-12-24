### AUIPC
*AUIPC* - Add Upper Immediate to PC. <br/>
Thanks to this we can save in any register program counter status and 20bits new adress. <br/>
This instruction is described on page 14 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf). 
As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way.
| ![auipc1](https://user-images.githubusercontent.com/43972902/103107554-c6600e80-463f-11eb-86b7-eb917b86ba3d.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [13.12.2020] |

| ![auipc2](https://user-images.githubusercontent.com/43972902/103107560-d677ee00-463f-11eb-97e2-045229275d22.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 14*  [13.12.2020] |


