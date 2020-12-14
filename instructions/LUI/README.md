### LUI
This instruction is described on page 14 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf). 
As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way.
| ![lui](https://user-images.githubusercontent.com/43972902/102013637-b861e200-3d51-11eb-84fd-82e637f4335e.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png*  [13.12.2020] |

| ![luimannual](https://user-images.githubusercontent.com/43972902/102015145-0b3f9780-3d5a-11eb-9fc1-90a92669eece.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 14*  [13.12.2020] |

**0 - 6:** 0110111 - It's *opcode*

**7 - 11:**  *rd* - it's destination, e.g. x1 register

**12 - 31:** *imm* - it's number what we want load. This register is 20 bits long, so we can load <img src="https://render.githubusercontent.com/render/math?math=2^{20}-1">  size number. <img src="https://render.githubusercontent.com/render/math?math=2^{20}-1"> is equal 1048575 in dec and 0xFFFFF in hex.

If we run instruction `lui x1, 0xFFFFF` in [simulator](https://www.kvakil.me/venus/), which is described on the main repository page, we can see that the instruction will be "translated" into corresponding machine code fffff0b7. fffff0b7 means in binary: 11111111111111111111 00001 0110111. What does it mean:
- First seven bits is our opcode: 0110111. Exacly the same like in manual :)
- Next five bits is our destination: 00001. 00001 like `x1` register :)
- The rest of the bits (20 bits): 11111111111111111111. This numbers means our number, which we want load to x1 register. If we translate 11111111111111111111 to hex we will get 0xFFFFF :)

Ok, but how exactly does this instruction work? `lui` operates on numbers with a length up to 20 bits (as 0xFFFFF), but our general purpose registers (like x1, x2...) have 32 bits length. So the result of `lui` is saved in first twenty bits, the rest of the bits are not touched. For example:
- If we run instruction `lui x1, 0xFFFFF` in `x1` register the `0xFFFFF000` value will be written.
- If we run instruction `lui x1, 0xFFFF` in `x1` register the `0x0FFFF000` value will be written.
- If we run instruction `lui x1, 0xFFF` in `x1` register the `0x00FFF000` value will be written.
- If we run instruction `lui x1, 0xFF` in `x1` register the `0x000FF000` value will be written.
- If we run instruction `lui x1, 0xF` in `x1` register the `0x0000F000` value will be written.
