# learningRISC-V
![logo](https://riscv.org/wp-content/uploads/2018/06/RISC-V-Logo-2.png)
_________________
In this project I'll put everything related to RISC-V. I learn this technology from scratch, so there may be a lot of simple things. I hope to avoid mistakes due to being inexperienced. I will try to keep up to date this repo.

### Table of contents
1. [Tutorials](#Tutorials)
2. [Simulator](#Simulator)
3. [Documentation](#Documentation)
4. [A little bit about registers](#registers)
5. [About the instructions](#instructions)
6. [Terms needing explanation](#terms)

### Tutorials:

1. First link is about very important tutorial for me. Why? Because it's in my mother language and I had easy access to it :) This tutorial has four parts. The first two describe what a RISC-V is, the basics of assembly language and how instructions work. The third part is discussed how to write own siple soft core using SystemVerilog language. The last part is describe implementation RISC-V on FPGA board (based on MAX10). This tutorial was published in the *Elektronika Praktyczna* magazine. Fortunately, however, the first part is available online for free:

    [08.12.2020] https://ep.com.pl/podzespoly/12992-risc-v-budujemy-wlasny-mikrokontroler-1

    The second part of the course is available in the issue from: 10.2019, pages 116-123/140

    The third part of the course is available in the issue from: 11.2019, pages 131-137/140

    The last part part (fourth) of the course is available in the issue from: 12.2019, pages 123-124/140
2.

### Simulator
For learning assembly language, I highly recommend using this simulator:
[08.12.2020] https://www.kvakil.me/venus/
This simulator has two parts:
- Editor - here we can write our code
When you click "Simulator" the code will be compiled[?] automatically.
- Simulator - here you can test the code and check the results
In `Editor`  part I entered the code:
```
addi x1, x1, 0x1
addi x2, x1, 0x1
```
In the screenshot, you can see at the top bookmarks `Editor` and `Simulator`.
![venus](https://user-images.githubusercontent.com/43972902/101664067-b34c1c80-3a4b-11eb-83a7-e17bc51d1271.png)
If you click `Reset`, the effect will be the same as a page refresh [?]. It means that all registers will be in factory state and we will go back to the first line of code.
`Step` is of course next code line, `Prev` means previous code line.
If you click `Dump` then at the bottom of the page in the` console output` field will appear machine code, that is executed by the processor.
```
00108093
00108113
```
If you click `Run`  all code will be executed. In this case, the x1 and x2 registers will change:
![venus_memory](https://user-images.githubusercontent.com/43972902/101665262-0e324380-3a4d-11eb-80f6-ef268bbe9608.png)

On the left side you can see register numbers (from 0 to 31) with their mnemonics. The contents of registers are displayed hexadecimal, this is the default. If you want to change it, in this part of page, at the bottom you have drop-down list `Display Settings`. There you can choose how you want to display the numbers: hexadecimal, decimal, unsigned or ASCII. In this part of page you have two bookmarks: `Registers` (I just described this part) and `Memory`. If you switch to the `Memory` tab, then you can see what is in the memory part: Text, Data, Heap or Stack. The default is Text.

![venus_memory_part](https://user-images.githubusercontent.com/43972902/101669479-438d6000-3a52-11eb-9fc6-58f44239e7ec.png)

Very important thing. If you go from the `Simulator` tab to the` Editor` it will be the same as clicking on the `Reset` button, so all registers will return to the factory state.

### Documentation
The documentation consists of three documents:
1. User-Level ISA Specification
There is the user level ISA specification. The most important thing is that it discusses the basic instructions and core elements. Here are highlighted instructions for RV32I, RV32E and RV64I.
What does ISA means is in *Terms needing explanation*.
2. Privileged ISA specification
It describes the elements of the processor, which are related with management of priority levels. It's used to how to start the operating system. Also are definied here interrupt handling or physical memory management.
3. Debug specification
Describes a standard, that enables debugging.

### A little bit about registers <a name="registers"></a>
here desc registers

### About the instructions <a name="instructions"></a>

### Terms needing explanation <a name="terms"></a>
1. ISA - lorem ipsum
2. Opcode - lorem ipsum













