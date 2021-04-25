### SW
**SW** - store word, it's a pseudoinstruction. This instruction saves value from any register to any address in memory. The easiest way to explain how it works will be an example. Imagine this code:
``` assembly
sw x1, 0x20, x8
```
This instruction will be converted to:
``` assembly
sw x1 32(x8)
```
And means: take value from *x1* and write all eigth bytes of that value to memory address at *0x20*. For an even better understanding of the topic, let's analyze this example: 
``` assembly
li      x1, 0x4
li      x8, 1
sw      x1, 0x20, x8
```
First instruction saves in *x1* register number *4*. <br/>
Second instruction saves in *x8* register number *1*. <br/>
Last instruction writes to *0x20* memory address, value which is stored in *x1* register at position from *x8* register. In our case memory looks like:
![swmem1](https://user-images.githubusercontent.com/43972902/115995092-29f04d80-a5da-11eb-8ad3-cba6d5e6fe4a.png)

In the red circle is our value from the register *x1*. Value is on the second position in *0x20* address, because we had `li x8, 1`. When we change last instruction to `li x8, 2`, we'll get:
![swmem2](https://user-images.githubusercontent.com/43972902/115995184-8a7f8a80-a5da-11eb-9b8c-15031470c550.png)

So, we can notice, that we wrote to the memory value on next byte in *0x20* address. When we change last instruction to `li  x8, 4`, we'll get:
![swmem3](https://user-images.githubusercontent.com/43972902/115995346-27dabe80-a5db-11eb-964f-66a8669926b2.png)

We can see in the picutre, that value was write to the first position in *0x24* address, because it's fifth byte from first position in *0x20*. <br/>
This instruction is described on page 19 in [ISA manual](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf). <br/>
Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way.

| ![swds](https://user-images.githubusercontent.com/43972902/115996217-aa18b200-a5de-11eb-99ab-0852432a236c.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 19* [25.04.2021] |

| ![swpi](https://user-images.githubusercontent.com/43972902/115996202-9c632c80-a5de-11eb-87cc-ffc14093eb6e.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png* [25.04.2021] |
