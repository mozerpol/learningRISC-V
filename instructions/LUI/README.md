### LUI
This instruction is described on page 14 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf). 
As each instruction consists of 32 bits. Below is a photo of the frame that describes what the bits do.
| ![lui](https://user-images.githubusercontent.com/43972902/102013637-b861e200-3d51-11eb-84fd-82e637f4335e.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [13.12.2020] |

<span style="color:red">0 - 6</span>: 0110111 - It's *opcode*
<span style="color:red">7 - 11</span>: *rd* - it's destination, e.g. x1 register
<span style="color:red">12 - 31</span>: *imm* - it's number what we want load. This register is 20 bits long, so we can load $2_{20}$ - 1  size number. $2_{20}$ - 1 is equal 1048575 in dec and 0xFFFFF in hex.

