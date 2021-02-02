### BNE
**BNE** - branch not equal. This instruction compares the contents of two registers, if they are different, then jump to the label. For example: `bne x2, x1, loop` means, if *x2* and *x1* are different, then jump to the *loop* label. <br/>
As each instruction consists of 32 bits. Below I posted two photos of the frame that describes what the bits do. The information inside them is exacly the same, but in a bit different way.
| ![bne2](https://user-images.githubusercontent.com/43972902/106637664-494f7f80-6583-11eb-8265-1af39b592d5d.png) |
|:--:|
| Source: *https://media.cheggcdn.com/media%2F707%2F707147b6-fa2f-4328-afd2-7a3d68c54a68%2FphpMU4I6Z.png* [02.01.2021]|

| ![bne1](https://user-images.githubusercontent.com/43972902/106637482-08f00180-6583-11eb-9af5-a13dfff56210.png) |
|:--:|
| Source: *RISC-V Instruction Set Manual v2.2, p 17*  [02.01.2021] |
