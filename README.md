# learningRISC-V
![logo](https://riscv.org/wp-content/uploads/2018/06/RISC-V-Logo-2.png)
_________________
In this project I'll put everything related to RISC-V. I learn this technology from scratch, so there may be a lot of simple things. I hope to avoid mistakes due to being inexperienced. I will try to keep up to date this repo.

### Table of contents <a name="tof"></a>
1. [Tutorials](#Tutorials)
2. [Simulator](#Simulator)
3. [Documentation](#Documentation)
4. [A little bit about registers](#registers)
5. [About the instructions](#instructions)
6. [Terms needing explanation](#terms)

### Tutorials:

1. First link is about very important tutorial for me. Why? Because it's in my mother language and I had easy access to it :) This tutorial has four parts. The first two describe what a RISC-V is, the basics of assembly language and how instructions work. The third part is discussed how to write own siple soft core using SystemVerilog language. The last part is describe implementation RISC-V on FPGA board (based on MAX10). This tutorial was published in the *Elektronika Praktyczna* magazine. Fortunately, however, the first part is available online for free: <br/>
    [08.12.2020] https://ep.com.pl/podzespoly/12992-risc-v-budujemy-wlasny-mikrokontroler-1 <br/>
    The second part of the course is available in the issue from: 10.2019, pages 116-123/140 <br/>
    The third part of the course is available in the issue from: 11.2019, pages 131-137/140 <br/>
    The last part part (fourth) of the course is available in the issue from: 12.2019, pages 123-124/140 <br/>

### Simulator <a name="Simulator"></a> [UP↑](#tof)
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

### Documentation <a name="Documentation"></a> [UP↑](#tof)
The documentation consists of three documents:
1. User-Level ISA Specification
There is the user level ISA specification. The most important thing is that it discusses the basic instructions and core elements. Here are highlighted instructions for RV32I, RV32E, RV64I and RV128I. What does ISA means is in [Terms needing explanation](#terms).
Link v2.2 [13.12.2020]: https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf
2. Privileged ISA specification
It describes the elements of the processor, which are related with management of priority levels. It's used to how to start the operating system. Also are definied here interrupt handling or physical memory management.
Link v1.10 [13.12.2020]: https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
3. Debug specification
Describes a standard, that enables debugging.
Link 0.13.2 [13.12.2020]: https://riscv.org/wp-content/uploads/2019/03/riscv-debug-release.pdf

### A little bit about registers <a name="registers"></a> [UP↑](#tof)
In this repository, I will focus on the RV32I version. RV32I means, that we have 32 general purpose registers, which are marked from x0 up to x31. x0 register is equal always 0! Each registry has a own purpose and it's good practice to follow this (eng version):
| ![register_meaning_eng](https://user-images.githubusercontent.com/43972902/101699645-cd9dee80-3a7b-11eb-8cf3-f64590fea00f.png) |
|:--:|
| Source: *https://web.eecs.utk.edu/~smarz1/courses/ece356/notes/risc/imgs/regfile.png*  [10.12.2020] |

Pl version:
| ![register_meaning_pl](https://user-images.githubusercontent.com/43972902/101699692-e8706300-3a7b-11eb-9c24-c183df05ee2e.png) |
|:--:|
| Source: *Elektronika Praktyczna 09.2019, p. 109*  |

For example x4 register is used as a thread pointer. 

### About the instructions <a name="instructions"></a> [UP↑](#tof)
There are 6 instruction formats in RISC-V:
1. **R** - instructions that use three registers as input, e.g. *add*, *xor* or *mul*
2. **I** - instructions with immediate loading, e.g. *lw*, *addi*, *jalr* or *slli*
3. **S** - storage instructions, e.g. *sw* or *sb*
4. **SB** - branch instructions, e.g. *bge* or *beq*
5. **U** - upper immediates, e.g. *lui* or *auipc*
6. **UJ** - jump instruction, e.g. *jal*
In RV32I version all instructions are 32 bits long. The first seven bits of LSB are opcode. The figure below shows what each bit means:

| ![opcodeexample](https://user-images.githubusercontent.com/43972902/101715627-1b2a5380-3a9c-11eb-887e-a9e0aac7de4a.png) |
|:--:|
| Source: *https://inst.eecs.berkeley.edu/~cs61c/resources/su18_lec/Lecture7.pdf*  [10.12.2020] |

The simplest family of instructions which operate on registers and constants is the OP family. It consists of 10 instructions operating on the *rs1* and *rs2* registers, and then writes the result to *rd*:
| ![opfamily](https://user-images.githubusercontent.com/43972902/101716069-e5399f00-3a9c-11eb-8ada-3df2ba8d2c0d.png) |
|:--:|
| Source: *Elektronika Praktyczna 09.2019, p. 109*  |

The OP family is of type R. Instructions from the OP-IMM family are shown below, as you can see, from the OP family it differs in bits 20 - 31:
| ![opimmfamily](https://user-images.githubusercontent.com/43972902/101716069-e5399f00-3a9c-11eb-8ada-3df2ba8d2c0d.png) |
|:--:|
| Source: *Elektronika Praktyczna 09.2019, p. 109*  |

The OP-IMM family allows code numbers in the range from -2048 to 2047. OP-IMM consists of 9 instructions corresponding to the OP, but mnemonics have the letter I.
Instructions from the OP or OP-IMM family carry out operations directly on constants and registers, but assembly language for RISC-V supports the use of something like abbreviations. By the abbreviation I mean a mnemonic name for one or few instructions. For example `nop` instruction is equal `addi x0, x0, 0`. `nop` means do nothing. The developers of RISC-V have made a lot of pseudo instructions (it's correct name for this: *pseudo instruction*). It's much easier and cleaner write `nop` than `addi x0, x0, 0`.The most common used pseudo instructions are presented below:
In English language:
| ![pseudoinstructionsENG](https://user-images.githubusercontent.com/43972902/101987122-76259b80-3c92-11eb-9275-cc6081bfb4b1.png) |
|:--:|
| Source: *https://web.eecs.utk.edu/~smarz1/courses/ece356/notes/assembly/imgs/pseudo.png*  [12.12.2020]  |

In Polish language:
| ![pseudoinstructionsPL](https://user-images.githubusercontent.com/43972902/101987112-6b6b0680-3c92-11eb-933a-3aa7e4111453.png) |
|:--:|
| Source: *Elektronika Praktyczna 09.2019, p. 110*  |

[Here](https://github.com/mozerpol/learningRISC-V/tree/main/instructions) I explain the most popular instructions with examples.

### Terms needing explanation <a name="terms"></a> [UP↑](#tof)
1. ISA <a name="ISA"></a> - *instruction set architecture* - is an abstract model of a computer. On this model consists of:
	- instruction listings - the set of instructions that the processor can execute,
	- data types - kind and range,
	- addressing mode - way to transfer data from registers to memory and vice versa,
	- set of registers available for the developer,
	- rules for handling threads and interrupts.
Examples of ISA: ARM, AMD64 or Intel 64.
2. Opcode <a name="Opcode"></a> - it's a number, that is a **fragment** of an instruction passed to the processor. It informs the processor what operation must be performed. Each assembly language command has a number and this command is converted to number during compilation.
3. Two's complement <a name="TWC"></a> - (abbreviated as U2, ZU2 or 2C, pl: *kod uzupełnień do dwóch*) - it's a system of representation of integer numbers in a binary system. MSB number tells us, whether the number is negative. For example `0b1000` will be negative, because MSB (first number from left) is 1, `0b0111` will be positive, because MSB (first number from left) is 0. Two's complement is currently one of the most popular way to write integers in digital systems. The reason is fact that addition and subtraction operations are performed the same as for unsigned binary numbers, due this can be able saved on processor instruction cycles. <br/>
<ins>How to convert U2 to dec?</ins> It is easy :) 
For example take number in U2: *0b101*. *101* - it has three numbers, first: *1*, second: *0*, third: *1*. Take first from left (it is *1*) and multiple it by <img src="https://render.githubusercontent.com/render/math?math=2^{2}">. Why *2*? Because we have three numbers, but **in computer science we count from zero** (usually ;p) :). And very important thing, the **first number and only first number** we must multiple by *-1*, because first number says whether the number is positive or negative. Next multiple *0* (because second number is 0) by <img src="https://render.githubusercontent.com/render/math?math=2^{1}">. Afterwards multiple *1* by <img src="https://render.githubusercontent.com/render/math?math=2^{0}">. So finally, we have: <img src="https://render.githubusercontent.com/render/math?math=101 = -1*2^{2} %2B 0*2^{1} %2B 1*2^{0} = -4 %2B 0 %2B 1 = -3">. <br/>
<ins>Another example</ins>(from wikipedia): <br/>
We have number in U2: `11101101` <br/>
And we must to do the same as in previous example. We have eight numbers. First number is *1*, so we must multiply <img src="https://render.githubusercontent.com/render/math?math=2^{7}"> by *-1*. Why *7*? Because we have eight numbers and in this method we count from zero. Why *-1*? because first number says whether the number is positive or negative (*1* - number is negative, *0* - number is positive). 
Next number is also *1*, so will be <img src="https://render.githubusercontent.com/render/math?math=1*2^{6}">.
Next number is also *1*, so will be <img src="https://render.githubusercontent.com/render/math?math=1*2^{5}">.
Next number is *0*, so will be <img src="https://render.githubusercontent.com/render/math?math=0*2^{4}">.
Some calculations further...
<img src="https://render.githubusercontent.com/render/math?math=11101101 = -1*(2^{7}) %2B 1*2^{6} %2B 1*2^{5} %2B 0*2^{4} %2B 1*2^{3} %2B 1*2^{2} %2B 0*2^{1} %2B 1*2^{0} = -128 %2B 109 = -19">. <br/>
I put below table with all the possible 4-bit numbers in U2 notation: 

| U2 | Calculations | Value |
|:---:|:---:|:---:|
| 0000 | 0 | 0 |
| 0001 | <img src="https://render.githubusercontent.com/render/math?math=2^{0}"> | 1 |
| 0010 | <img src="https://render.githubusercontent.com/render/math?math=2^{1}"> | 2 |
| 0011 | <img src="https://render.githubusercontent.com/render/math?math=2^{1}%2B2^{0}"> | 3 |
| 0100 | <img src="https://render.githubusercontent.com/render/math?math=2^{2}"> | 4 |
| 0101 | <img src="https://render.githubusercontent.com/render/math?math=2^{2}%2B2^{0}"> | 5 |
| 0110 | <img src="https://render.githubusercontent.com/render/math?math=2^{2}%2B2^{1}"> | 6 |
| 0111 | <img src="https://render.githubusercontent.com/render/math?math=2^{2}%2B2^{1}%2B2^{0}"> | 7 |
| 1000 | <img src="https://render.githubusercontent.com/render/math?math=-2^{3}"> | -8 |
| 1001 | <img src="https://render.githubusercontent.com/render/math?math=-2^{3}%2B2^{0}"> | -7 |
| 1010 | <img src="https://render.githubusercontent.com/render/math?math=-2^{3}%2B2^{1}"> | -6 |
| 1011 | <img src="https://render.githubusercontent.com/render/math?math=-2^{3}%2B2^{1}%2B2^{0}"> | -5 |
| 1100 | <img src="https://render.githubusercontent.com/render/math?math=-2^{3}%2B2^{2}"> | -4 |
| 1101 | <img src="https://render.githubusercontent.com/render/math?math=-2^{3}%2B2^{2}%2B2^{0}"> | -3 |
| 1110 | <img src="https://render.githubusercontent.com/render/math?math=-2^{3}%2B2^{2}%2B2^{1}"> | -2 |
| 1111 | <img src="https://render.githubusercontent.com/render/math?math=-2^{3}%2B2^{2}%2B2^{1}%2B2^{0}"> | -1 | 

4. Program Counter (PC) <a name="PC"></a> - 








