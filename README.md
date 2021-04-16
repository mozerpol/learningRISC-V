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
7. [Core structure](#core)
8. [Operations on registers](#oper)
9. [Pipelining](#pipel)

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
- Editor - here we can write our code. When you click "Simulator" the code will be compiled[?] automatically.
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
If you click `Dump` then at the bottom of the page in the `console output` field will appear machine code, that is executed by the processor.
```
00108093
00108113
```
If you click `Run`  all code will be executed. In this case, the x1 and x2 registers will change:
![venus_memory](https://user-images.githubusercontent.com/43972902/101665262-0e324380-3a4d-11eb-80f6-ef268bbe9608.png)

On the left side you can see register numbers (from 0 to 31) with their mnemonics. The contents of registers are displayed hexadecimal, this is the default. If you want to change it, in this part of page, at the bottom you have drop-down list `Display Settings`. There you can choose how you want to display the numbers: hexadecimal, decimal, unsigned or ASCII. In this part of page you have two bookmarks: `Registers` (I just described this part) and `Memory`. If you switch to the `Memory` tab, then you can see what is in the memory part: Text, Data, Heap or Stack. The default is Text.

![venus_memory_part](https://user-images.githubusercontent.com/43972902/101669479-438d6000-3a52-11eb-9fc6-58f44239e7ec.png)

Very important thing. If you go from the `Simulator` tab to the `Editor` it will be the same as clicking on the `Reset` button, so all registers will return to the factory state.

### Documentation <a name="Documentation"></a> [UP↑](#tof)
The documentation consists of three documents:
1. User-Level ISA Specification <br/>
There is the user level ISA specification. The most important thing is that it discusses the basic instructions and core elements. Here are highlighted instructions for RV32I, RV32E, RV64I and RV128I. What does ISA means is in [Terms needing explanation](#terms).
Link v2.2 [13.12.2020]: https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf
2. Privileged ISA specification <br/>
It describes the elements of the processor, which are related with management of priority levels. It's used to how to start the operating system. Also are definied here interrupt handling or physical memory management.
Link v1.10 [13.12.2020]: https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
3. Debug specification <br/>
Describes a standard, that enables debugging.
Link 0.13.2 [13.12.2020]: https://riscv.org/wp-content/uploads/2019/03/riscv-debug-release.pdf

### A little bit about registers <a name="registers"></a> [UP↑](#tof)
In this repository, I will focus on the RV32I version. RV32I means, that we have *32* general purpose registers, which are marked from *x0* up to *x31*. *x0* register is equal always *0*! Each registry has a own purpose and it's good practice to follow this (eng version):
| ![register_meaning_eng](https://user-images.githubusercontent.com/43972902/101699645-cd9dee80-3a7b-11eb-8cf3-f64590fea00f.png) |
|:--:|
| Source: *https://web.eecs.utk.edu/~smarz1/courses/ece356/notes/risc/imgs/regfile.png*  [10.12.2020] |

Pl version:
| ![register_meaning_pl](https://user-images.githubusercontent.com/43972902/101699692-e8706300-3a7b-11eb-9c24-c183df05ee2e.png) |
|:--:|
| Source: *Elektronika Praktyczna 09.2019, p. 109*  |

For example *x4* register is used as a thread pointer. 

### About the instructions <a name="instructions"></a> [UP↑](#tof)
There are 6 instruction formats in RISC-V:
1. **R** - instructions that use three registers as input, e.g. *add*, *xor* or *mul*.
2. **I** - instructions with immediate loading, e.g. *lw*, *addi*, *jalr* or *slli*.
3. **S** - storage instructions, e.g. *sw* or *sb*.
4. **SB** - branch instructions, e.g. *bge* or *beq*.
5. **U** - upper immediates, e.g. *lui* or *auipc*.
6. **UJ** - jump instruction, e.g. *jal*.
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

The OP-IMM family allows code numbers in the range from -2048 to 2047. OP-IMM consists of 9 instructions corresponding to the OP, but mnemonics have the letter *I*. <br/>
Instructions from the OP or OP-IMM family carry out operations directly on constants and registers, but assembly language for RISC-V supports the use of something like abbreviations. By the abbreviation I mean a mnemonic name for one or few instructions. For example `nop` instruction is equal `addi x0, x0, 0`. `nop` means do nothing. The developers of RISC-V have made a lot of pseudo-instructions (it's correct name for this: *pseudo-instruction*). It's much easier and cleaner write `nop` than `addi x0, x0, 0`.The most common used pseudo-instructions are presented below: <br/>
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
1. ISA <a name="ISA"></a> - *instruction set architecture*
It is an abstract model of a computer. On this model consists of:
	- instruction listings - the set of instructions that the processor can execute,
	- data types - kind and range,
	- addressing mode - way to transfer data from registers to memory and vice versa,
	- set of registers available for the developer,
	- rules for handling threads and interrupts.
Examples of ISA: ARM, AMD64 or Intel 64.
2. Opcode <a name="Opcode"></a>
It's a number, that is a **fragment** of an instruction passed to the processor. It informs the processor what operation must be performed. Each assembly language command has a number and this command is converted to number during compilation.
3. Two's complement <a name="TWC"></a> - (abbreviated as U2, ZU2 or 2C, pl. *kod uzupełnień do dwóch*). <br/>
It's a system of representation of integer numbers in a binary system. MSB number tells us, whether the number is negative. For example `0b1000` will be negative, because MSB (first number from left) is 1, `0b0111` will be positive, because MSB (first number from left) is 0. Two's complement is currently one of the most popular way to write integers in digital systems. The reason is fact that addition and subtraction operations are performed the same as for unsigned binary numbers, due this can be able saved on processor instruction cycles. <br/>
How to convert U2 to dec? It is easy :) <br/>
For example take number in U2: *0b101*. *101* - it has three numbers, first: *1*, second: *0*, third: *1*. Take first from left (it is *1*) and multiple it by <img src="https://render.githubusercontent.com/render/math?math=2^{2}">. Why *2*? Because we have three numbers, but **in computer science we count from zero** (usually ;p) :). And very important thing, the **first number and only first number** we must multiple by *-1*, because first number says whether the number is positive or negative. Next multiple *0* (because second number is 0) by <img src="https://render.githubusercontent.com/render/math?math=2^{1}">. Afterwards multiple *1* by <img src="https://render.githubusercontent.com/render/math?math=2^{0}">. So finally, we have: <img src="https://render.githubusercontent.com/render/math?math=101 = -1*2^{2} %2B 0*2^{1} %2B 1*2^{0} = -4 %2B 0 %2B 1 = -3">. <br/>
Another example (from wikipedia): <br/>
We have number in U2: `11101101` <br/>
And we must to do the same as in previous example. We have eight numbers. First number is *1*, so we must multiply <img src="https://render.githubusercontent.com/render/math?math=2^{7}"> by *-1*. Why *7*? Because we have eight numbers and in this method we count from zero. Why *-1*? because first number says whether the number is positive or negative (*1* - number is negative, *0* - number is positive). 
Next number is also *1*, so will be <img src="https://render.githubusercontent.com/render/math?math=1*2^{6}">.
Next number is also *1*, so will be <img src="https://render.githubusercontent.com/render/math?math=1*2^{5}">.
Next number is *0*, so will be <img src="https://render.githubusercontent.com/render/math?math=0*2^{4}">.
Some calculations further...
<img src="https://render.githubusercontent.com/render/math?math=11101101 = -1*(2^{7}) %2B 1*2^{6} %2B 1*2^{5} %2B 0*2^{4} %2B 1*2^{3} %2B 1*2^{2} %2B 0*2^{1} %2B 1*2^{0} = -128 %2B 109 = -19">. <br/>
I put below table with all the possible 4-bit numbers in U2 notation: <br/>

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

4. Program Counter (PC) <a name="PC"></a> - or sometimes called *Instruction Pointer* (IP) <br/>
It's program counter/pointer, register of the processor in which the address of the current or the next instruction is stored. In other words, PC is a processor register that indicates where a computer is in its program sequence. Usually, the PC is incremented after fetching an instruction, and holds the memory address of ("points to") the next instruction that would be executed. By modifying this register jumps, subroutine calls and returns are implemented. 

5. Address space <a name="adrSpac"></a> <br/>
It is a memory map, which is available for memory process, which may correspond to a network host, peripheral device or disk sector. The most common things of the address space is: 
- [Machine code](https://en.wikipedia.org/wiki/Machine_code) - is a low-level programming language used to directly control a computer's central processing unit (CPU). 
- [Shared memory](https://en.wikipedia.org/wiki/Shared_memory) - is memory that may be simultaneously accessed by multiple programs. 
- [Dynamic library](https://en.wikipedia.org/wiki/Dynamic-link_library) - a kind of library that is connected with the executable program only at the moment of its execution. Example of dynamic library is *Dynamic-Link Library* (*.dll), typical dynamic library for Microsoft Windows. 
- [Stack](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) - it is an mathematical model for data types that serves as a collection of elements, with two main principal operations: **push**, which adds an element to the collection, and **pop**, which removes the most recently added element that was not yet removed.

| ![stack](https://user-images.githubusercontent.com/43972902/114309406-49ba4880-9ae7-11eb-87e9-18666f06925a.png) |
|:--:|
| *Simple representation of a stack runtime with push and pop operations* |

- [Heap](https://en.wikipedia.org/wiki/Heap_(data_structure)) - it's a tree-based data structure in which the values of the children are in a constant relationship to the parent's value (for example, the parent's value is not less than its child's values). In a heap, the highest (or lowest) priority element is always stored at the root (root means top node). The heap is not a sorted structure. The heap is a useful data structure when it is necessary to repeatedly remove the object with the highest (or lowest) priority.

| ![heap](https://user-images.githubusercontent.com/43972902/114309615-0c09ef80-9ae8-11eb-9dda-6b57d44c6365.png) |
|:--:|
| *Example of a binary max-heap with node keys being integers between 1 and 100* |

- Initialized data - so called *.data* <br/>
The .data segment contains any global or static variables which have a pre-defined value and can be modified. That is any variables that are not defined within a function (and thus can be accessed from anywhere) or are defined in a function but are defined as static so they retain their address across subsequent calls.

| ![bsslay](https://user-images.githubusercontent.com/43972902/114317995-1c7f9180-9b0b-11eb-96ee-3a91ae016376.png) |
|:--:|
| *This shows the typical layout of a simple computer's program memory with the text, various data, and stack and heap sections* |
| Source: *https://en.wikipedia.org/wiki/.bss* |

- Uninitialized data - so called *BSS section* - *block starting symbol* <br/>
It's the portion of (pol. *jest częścią*) code that contains statically allocated variables that are declared but have not been assigned a value yet. On some platforms, some or all of the bss section is initialized to zeroes.
- Text - the code segment, also known as a text segment, contains executable instructions and is generally read-only and fixed size. <br/><br/>
Not all memory from memory map has to be equivalent in physical memory, it can be implemented by virtual memory mechanism. 
6. Virtual memory <a name="virtMem"></a> <br/>
It's a computer memory management mechanism that gives the process the impression (pol. *wrażenie*) of working in one large, continuous/uniform area of main memory while physically it may be fragmented, discontinuous, and partially stored on storage devices. Using different words. It's a computer concept where the main memory is broken up into a series of individual pages. Those pages can be moved in memory as a unit, or they can even be moved to secondary storage to make room in main memory for new data. In essence, virtual memory allows a computer to use more RAM then it has available.
7. C-string <a name="Cstr"></a> - a string of characters in the style of the *C language*, that is, a byte array terminated with a zero.  
8. Assembly directives - also called pseudo-opcodes <br/>
The names of pseudo-ops often start with a dot like *.data* or *.asiiz*. Assembly directives are commands for assembler that tell to perform operations other than assembler instructions. Directives affect how the assembler operates and may affect the finish code.
9. .asciiz - assembly directive <br/>
`.asciiz` means that the string is terminated by the `\0` (ASCII code *0*, *NULL* character). They are even called *C-strings*.

### Core structure <a name="core"></a> [UP↑](#tof)
The core can be divided into: *data path* and *control path*. *Data path* consists of processing elements (like ALU), *control path* generate signals which control the *datinzynierzya path*. 

| ![dataPath](https://user-images.githubusercontent.com/43972902/114409650-f3aed900-9baa-11eb-99fb-3b099da377fd.png) |
|:--:|
| *Diagram of the data path of the implemented microcontroller* |
| Source: *Elektronika Praktyczna 10.2019, p. 117*  |

Above diagram shows the *data path* without *clock* and reset *paths* (for clarity). Dark blue mark registers and light blue is for combinational logic (mux, alu, etc.). Paths terminated with arrows are connected to *control path*. Memory address to which the microcontroller wants to access is set in the *ADDR*. The read value will appear in the *RDATA* register in the next clock cycle. <br/>
Part on this diagram *mux_mem_addr* is responsible for value in *PC* register, on the next rising edge. Usually it'll be an address of the next instruction (*PC+4*), however, in the case of jumps will select value from *ALU* (this *ALU* in the upper right corner). Sometimes it may be a good idea to go back to the last instruction, for it responsible is *PC-4*. THe decision is made by *pc_sel* it's part of *control path*. <br/>
Next multiplexer (between *PC* and *ADDR*) is controlled by *mem_sel*, it's responsible for whether memory is to be addressed from *PC* register or output of *ALU*. First option allow load next instruction, second allow fetch or save data. So a little bit I don't understand... So from one hand I have two possibilities: 1. load to memory next instruction from *PC*, 2. save or download data from somewhere. Sounds very slow, because I want in the same time save data and load next instruction, but maybe I don't understand something. Ok, but... <br/>
In the next clock cycle the value from the given address will be taken to *RDATA* and simultaneously go to input two parts: *inst_mgm* and *select_rd*. *select_rd* is responsible for downloading data from memory. <br/>
Thanks to path *init_sel* we can select wheter next instruction will be *nop* or the same as previous instruction. <br/>
From *INST* register instruction will go to the *decode* block. *decode* block is responsible for dividing instruction on smaller parts. <br/>
Next important part is *reg_file*. It has five inputs (exactly six - clock - but not shown in this diagram):
1. *rs1*, *rs2* and *rd* - allow the selection of vectors for writing and reading 
2. *rd_d* - bring the data
3. *wr* - allowing for saving data
In this block (*reg_file*) we have only two outputs:
1. *rs_1_d* and *rs_2_d* - contain data from selecting registers. 
Blocks *select_wr* and *select_rd* allow the selection of bytes that may be write or read from memory. <br/>
Module *z^-2* (right upper corner) is responsible for delaying signal for two clocks. 

Access to the memory, loading data into the *INST* register takes one clock for each step, a total three clocks. It means that fetching and executing one instruction takes three clocks: <br/>
1. set memory addres -> 2. fetch instruction -> 3. execute

However, it's possible to shorten this time for a larger number of instructions. It's called [pipelining](https://github.com/mozerpol/NotesFromLearning/tree/main/Microprocessor-Design#Pipelining). Thanks to this we can execute three instructions in 5 clocks instead 9. <br/>
In first step we are setting the adress of first instruction. <br/> 
Next during second clock first step are saving to the *INST* reg and simultaneously we are setting the addres of second instruciton. <br/>
During third clock first instruction is executing, second instruction is saving to the *INST* reg and we are setting the address of third instruction. <br/>
So we can say that our pipelinig has three stages, thanks to this we can execute three instructions in 5 clocks instead 9. Generally execution of *n* instructions divided by *p* steps will take *n*+*p*-*1* clocks instead *n* * *p*. But sometimes pipelining, especially in large processors is a problem. For example when we have jump instructions. The address of next instruction we know on the last stage (in our case it'll be third stage - then we know in case jump instruction which instruction will be next). It means that sometimes in pipelining, core must have clean the all instructions from pipeline. In our case cleaning pipeline will take two clocks more for filling pipeline once again. In our processor it's not a big problem, but for large devices with a lot of stages it can be very time-consuming, so sometimes to avoid this (cleaning pipeline) engineers are implementing branch prediction methods.

### Operations on registers <a name="oper"></a> [UP↑](#tof)

| ![flowDiagram](https://user-images.githubusercontent.com/43972902/114609471-24703a80-9c9f-11eb-8357-ac53b80aba46.png) |
|:--:|
| *Data flow for OP-IMM family* |
| Source: *https://gitlab.com/rysy_core/rysy_core* |

Steps executing instruction `aadi` (from *OP-IMM* family) based on the image above:
1. Program execution begins by resetting the entire circuit. It means that *PC* reg has value *0* at the begining. Value *0* points at first instruction.
2. Before when instruction `aadi` will go to the *INST* reg we must wait two clock cycles, because we must fill pipeline.
3. At begining, during two first clock cycles we must load to *INST* register *nop* instruction. 
Above three steps aren't marked in the picture, but they are very important. Next steps will show how data flow looks in the circuit. The orange line show dataflow for instruction from *OP-IMM* family, that is our `addi` instruction.
4. Multiplexer in *mux_mem_addr* select that *PC* will be increment by *4*, it means, that now *PC* reg shows at our `addi` instruction.
5. Multiplexer *mem_sel* select, that memory will be addressed value from *PC* reg.
6. *inst_sel* load instruction from *RDATA*, where is `addi`. 
Currently, at this moment we have inside *INST* register `addi` instruction.
7. From *INST* instrution is going to *decode* block, which divide instruction to smaller parts such as *opcode* or different values. 
8. Every time *decode* will generate every possibility, for every family, even it doesn't make sense. Which possibility will be used is decided by the control block by multiplexers with *imm_type* path. In our case (*addi* belongs to *OP-IMM* family) will be *rs1*, *rd* and *imm_I* (just look at frame for *OP-IMM* family. We have *imm*, *rs1*, *func3*, *rd* and *opcode*). 
9. Value *imm* (in *OP-IMM* family) and value *rs2_d* (this argument is from different family) are at the same bits. So if we have *OP-IMM* family we don't want use *rs2_d* value. What to choose is decided by the multiplexer which is control by *alu2_sel*. We can notice in the diagram, that we have two possibilities: 1. *imm_I* 2. *rs2_d*, but in *OP-IMM* family we want *imm_I*, not *rs2_d*.
10. The operation that *ALU* must do will be selected in the path *alu_op*. *alu_op* will be set based on the field *func3*.
11. The result of operations *rd_d* will be directed through *ALU* and multiplexer which is controlled by *rd_sel* path once again to *reg_file*. 
12. High state on the *wr* will cause, taht result will be save in register. 

Below is diagram which presents dataflow for *OP* instructions family. 
| ![flowDiagramOP](https://user-images.githubusercontent.com/43972902/114924566-6d0a2e00-9e2e-11eb-8aa6-8cf3cd445599.png) |
|:--:|
| *Data flow for OP family* |
| Source: *https://gitlab.com/rysy_core/rysy_core* |

Steps executing instruction `aad` (from *OP* family) based on the image above. The steps are exactly the same as above, exept 12 and 13 steps:
1. Program execution begins by resetting the entire circuit. It means that *PC* reg has value *0* at the begining. Value *0* points at first instruction.
2. Before when instruction `aad` will go to the *INST* reg we must wait two clock cycles, because we must fill pipeline.
3. At the begining, during two first clock cycles we must load to *INST* register *nop* instruction. 
This three steps from above aren't marked in the picture, but they are very important. Next steps will show how data flow looks in the circuit. The orange line show dataflow for instruction from *OP* family, that is our `add` instruction.
4. Multiplexer in *mux_mem_addr* select that *PC* will be increment by *4*, it means, that now *PC* reg shows at our `add` instruction.
5. Multiplexer *mem_sel* select, that memory will be addressed value from *PC* reg.
6. *inst_sel* load instruction from *RDATA*, where is `add`. 
Currently, at this moment we have inside *INST* register `add` instruction.
7. From *INST* instrution is going to *decode* block, which divide instruction to smaller parts such as *opcode* or different values. 
8. Every time *decode* will generate every possibility, for every family, even it doesn't make sense. 
9. Values *rs1* and *rs2* will go to the *reg_file*, so in this case is not necessary use multiplexer by *imm_type*. 
10. We are using *rs2* so multiplexer will be control by *alu2_sel* and take value *rs2_d* from *reg_file*. This is the only difference between the *OP-IMM* and *OP* family. 
11. The result of operations *rd_d* will be directed through *ALU* and multiplexer which is controlled by *rd_sel* path once again to *reg_file*. 
12. High state on the *wr* will cause, taht result will be save in register. 

| ![pipePhase](https://user-images.githubusercontent.com/43972902/115012618-56a4b680-9eb0-11eb-918d-9a93095925b8.png) |
|:--:|
| *Each phase for pipelining* |
| Source: *Elektronika Praktyczna 10.2019, p. 122*  |

### Pipelining <a name="pipel"></a> [UP↑](#tof)











