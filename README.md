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
8. [Operations on registers and data flow](#oper)
9. [Pipelining](#pipel)
    1. [Pipelining for jump instructions](#pipeljal)
    2. [Pipelining for conditional jumps](#pipeljump)

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

### Operations on registers and data flow <a name="oper"></a> [UP↑](#tof)
#### Data flow for "I" format (OP-IMM family)

| ![flowDiagram](https://user-images.githubusercontent.com/43972902/114609471-24703a80-9c9f-11eb-8357-ac53b80aba46.png) |
|:--:|
| *Data flow for "I" format* |
| Source: *https://gitlab.com/rysy_core/rysy_core* |

Steps executing instruction `addi` (from *OP-IMM* family) based on the image above:
1. Program execution begins by resetting the entire circuit. It means that *PC* reg has value *0* at the begining. Value *0* points at first instruction.
2. Before when instruction `addi` will go to the *INST* reg we must wait two clock cycles, because we must fill pipeline.
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

#### Data flow for "R" format (OP family)

Below is diagram which presents dataflow for "I" format instructions (*OP* family). 
| ![flowDiagramOP](https://user-images.githubusercontent.com/43972902/114924566-6d0a2e00-9e2e-11eb-8aa6-8cf3cd445599.png) |
|:--:|
| *Data flow for "R" format* |
| Source: *https://gitlab.com/rysy_core/rysy_core* |

Steps executing instruction `add` (from *OP* family) based on the image above. The steps are exactly the same as above, exept 12 and 13 steps:
1. Program execution begins by resetting the entire circuit. It means that *PC* reg has value *0* at the begining. Value *0* points at first instruction.
2. Before when instruction `add` will go to the *INST* reg we must wait two clock cycles, because we must fill pipeline.
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

#### Data flow for "UJ" format

| ![jaldataflow](https://user-images.githubusercontent.com/43972902/115146035-29453d80-a055-11eb-9c28-62a3e85a302e.png) |
|:--:|
| *Data flow for jal instruction* |
| Source: *https://gitlab.com/rysy_core/rysy_core* |

The initial data flow for *UJ*-type instructions is very similar as for *OP* family (above steps). The above example is for *jal* instruction, which perform jump to the selected adress and save in chosen register how many steps you want to go back. <br/>
Path *pc_sel* gives value to *PC* register, which directly comes from *ALU*. It means that address for next instruction (because *PC* point to the next instruction) is the result of *ALU*. <br/>
The instruction from the new address will enter to the execution phase after two cycles, for this reason the control part (*inst_mgm* part) will have to replace the next two instructions with *nop* instructions. This is controlled by *inst_sel* path. <br/>
The multiplexer which is controlled by *imm_type* select *J* constant type, then multiplexer which is controlled by *alu2_sel* allow *J* constant type go to *ALU*. <br/>
To the *rd* register (in *reg_file*) will be saved the address of the next instruction, which would have been (pol. *która byłaby*) executed if the instruction had not been jumped. This value which would have been executed is the *PC* value delayed by one clock cycle (it's the address of the next instruction). <br/>
Path *alu_op* select adding for this instruction.

#### Data flow for "JALR" instruction
| ![jalrdataflow](https://user-images.githubusercontent.com/43972902/115148747-539cf800-a061-11eb-86e2-6f2a4a15bf1c.png) |
|:--:|
| *Data flow for jalr instruction* |
| Source: *https://gitlab.com/rysy_core/rysy_core* |

*JALR* instruction belongs to *I* type format which was fully described above (by the way of the instruction *addi*). The data flow is very similar to *JAL* instruction.

#### Data flow for "U" format
| ![luidataflow](https://user-images.githubusercontent.com/43972902/115145328-45df7680-a051-11eb-80c1-86d4ec8d3c84.png) |
|:--:|
| *Data flow for lui instruction* |
| Source: *https://gitlab.com/rysy_core/rysy_core* |

| ![auipcdataflow](https://user-images.githubusercontent.com/43972902/115145384-8808b800-a051-11eb-8b71-55fe9ca276d6.png) |
|:--:|
| *Data flow for auipc instruction* |
| Source: *https://gitlab.com/rysy_core/rysy_core* |

#### Data flow for conditional instructions
| ![condjmp](https://user-images.githubusercontent.com/43972902/115286418-5544e980-a14f-11eb-974d-6a2f5e09907f.png) |
|:--:|
| *Data flow for conditional instructions. Paths which depend on the state are marked with dashed lines: orange for a possible jump and red for impossible jump.* |
| Source: *Elektronika Praktyczna 11.2019, p. 132*  |

From *reg_file* two instruction arguments *rs1_d* and *rs2_d* are passed to *CMP*. Thanks to *cmp_op* is selected the type of condition. If this condition is fulfilled then path *b* becomes high. In the same time *ALU* sums up the value in PC rgister (delayed by two cycles) with *imm* variable. Based on path state *b* control part (*inst_mgm* part) will consider whether next value for *PC* will be increment by 4 (no jump) or from *ALU* (jump). 

### Pipelining <a name="pipel"></a> [UP↑](#tof)
We know that execution the three instructions will take five cycle clocks (instead 9), because execution of *n* instructions divided by *p* steps will take *n*+*p*-*1* clocks instead *n* * *p*.
| ![pipePhase](https://user-images.githubusercontent.com/43972902/115115423-b5dbf700-9f94-11eb-8fc9-7bd260f1bc31.png) |
|:--:|
| *Each phase for pipelining* |
| Source: *Elektronika Praktyczna 10.2019, p. 122*  |

Above picture is horizontally divided by five parts (because we have five clock cycles) and vertically divided by three pats (because we have three instructions). The *ALU* execute simultaneously during one clock three small parts: 1. set address, fetch, execute, in our case:
1. First clock, ALU will simultaneously execute:
    - `addi x1, x0, 10`; `rubbish`; `nop` <br/>
    As we can see in the picture in the first clock cycle address point to first instruction: `addi x1, x0, 10`. <br/>
    In the same time small part of *ALU* will fetch rubbish to *RDATA* register, because we don't know on which address was previously pointed, but it's not a proble. It's only fetching data to register, wihtout executing. <br/>
    At the same time *ALU* will execute *nop* instruction which was placed there during reset device.
2. Second clock, ALU will simultaneously execute:
    - `addi x2, x0, 5`; `addi x1, x0, 10`; `nop` <br/>
    In the next clock cycle (second) address was set to instruction number two (`addi x2, x0, 5`), while instruction number one was saved in *INST* register. <br/>
    In the execution phase we would have previously loaded *rubbish*, but the control part will have to ensure that it will be overwritten by the second *nop* instruction. 
3. Third clock, ALU will simultaneously execute:
    - `add x3, x2, x1`; `addi x2, x0, 5`; `addi x1, x0, 10` <br/>
    In the third clock cycle will execute first our instruction `addi x1, x0, 10`. Now, in this time (third clock cycle), when each part our core is busy.
4. Fourth clock, ALU will simultaneously execute:
    - `nop`; `add x3, x2, x1`; `addi x2, x0, 5` <br/>
    In the fourth clock cycle will execute second our instruction `addi x2, x0, 5`, while address is pointing to first *nop* instruction.
5. Fifth clock, ALU will simultaneously execute:
    - `nop`; `nop`; `add x3, x2, x1` <br/>
    In the fifth will be executed last part our code `add x3, x2, x1`.

So we run these instructions:
| Instruction | Equivalent machine code |
|:--:|:--:|
| addi x1, x0, 10 | 00a00093 |
| addi x2, x0, 5 | 00500113 |
| add x3, x2, x1 | 001101b3 |
| addi x0, x0, 0 | 00000013 |
| addi x0, x0, 0 | 00000013 |

Now we can run our code in *ModelSim* to see how core works. After execution above code in simulator we will see this waveform:
![waveform1](https://user-images.githubusercontent.com/43972902/115115237-8d9fc880-9f93-11eb-9c29-401874341ec0.png)

Number meanings:
1. First line - *clk*. Clock cycle, every event in our processor can happen only when is rising edge. 
2. Second line - *rst*. Reset processor, it's activated by rising edge. In our waveform it happened at the beginning (0 sec), but deactivating reset took place in 2,5 μs, so our processor can work from the next edge of the rising clock cycle (it's 3 μs). 
3. Third line - *PC* value. It shows value inside PC counter. With the first rising clock cycle value inside *PC* is *0*, it happend in 1 μs. Next *PC* value, during the nearest rising clock cycle is immposible, beacue *rst* is active. So, after deactivating reset with rising clock cycle, then we can change value in *PC*. So the next value is in 3 μs and is equal 4. Thus, if *rst* is deactivated, the value of *PC* will increment by 4 with each incremental clock cycle. 
4. Fourth line - *q signal*. This is the value read from memory. We can see in the screenshot, that the first value in *q* is `00a00093`. If we look at the table with our code, which we run in the simulator (to see this waveform) we can notice that first instruction is `addi x1, x0, 10` and the equivalent machine code for this instruction is `00a00093`. Next instruction in our table is `addi x2, x0, 5` and the equivalent machine code for this is `00500113`, exactly the same as *q signal*. Thus, *q signal* corresponds to the value read from memory. 
5. Fifth line - *inst*. This is the register that stores the code of the currently executing instruction. At the beginning in our pipeline we have *nop* instruction for executing. *nop* is `00000013`. After *nop* in *inst* we can see instructions from *q signal*, like `00a00093` or `00500113`. The last instruction to execute is also *nop*.
6. Sixth line - *x1*. The last three lines contain register values *x1*, *x2*, *x3*.
7. Seventh line - *x2*.
8. Eigth line - *x3*.

#### Pipelining for jump instructions (in case of *jal*) <a name="pipeljal"></a> [UP↑](#tof)
So we run these instructions:
| Address in PC | Instruction | Instruction after assembling | Equivalent machine code | 
|:--:|:--:|:--:|:--:|
| 0x00 | addi x5, x0, 0 | addi x5, x0, 0 | 0x00000293 |
|  | loop: |  |  |
| 0x04 | addi x5, x5, 1 | addi x5, x5, 1 | 0x00128293 |
| 0x08 | jal x1, loop | jal x1, -4 | 0xffdff0ef |

For the record: *jal* instruction perform jump to the selected adress and save in chosen register how many steps you want to go back. So if we run these code from our table:
1. First line. Reset the *x5* register.
2. Second line. Increment *x5* register.
3. Third line. Jump to previous line (because we're going to *loop* label) and execute this line, so we jumped to previous line and increment once again *x5* register. <br/>
So we can say that this code is an infinite loop that increments the register *x5*. 

| ![jalpipe](https://user-images.githubusercontent.com/43972902/115230543-ce731b00-a114-11eb-9476-01041a9441c0.png) |
|:--:|
| *Instruction pipeline during program execution from above table for two jump iteration. The numbers indicate the address from which the instruction comes. The red color symbolizes that this memory fragment does not contain any meaningful data.* |
| Source: *Elektronika Praktyczna 11.2019, p. 132*  |

Above we can see pipeline for two first loops. As we know, after restart processor the first two instructions to execute are *nop* (the control part forces the execution of these instructions, the control part is *inst_mgm*). <br/>
In the third cycle is executing instruction which is placed at *0x00* position in memory, in our case it's `addi x5, x0, 0`. <br/>
In fourth clock cycle is executing next instruction: `addi x5, x5, 1`. This instruction is the part of our loop, which increment *x5* register. **BUT** in the same time we can see, that the address of the next instruction is *0x0c*. When we look at table, we notice that we don't have instruction at this address. The red color symbolizes that this memory fragment like *0x0c* doesn't contain any meaningful data. At this stage, the processor doesn't know that will be perform jump to another address than *0x0c* and this address (*0x0c*) is wrong. The jump instruction is executed in the next clock cycle. <br/>
In fifth clock cycle we have two wrong instructions: *0x0c* and *0x10*. At this stage, the control part (the control part is *inst_mgm*) must work. As in the case of a reset, the control part replaces two wrong instructions with the *nop* instruction. During this action, the processor will clean pipeline from wrong instructions until the last instruction from executable phase (*0x04*) will be perform. It'll take two clock cycles: sixth and seventh. <br/>
So we can notice on the contrary to the instructions which perform simple saving to the register like *addi* or *add* jump will take three clock cycles.  


When we run the above code in ModelSim until 13 μs (13 μs is exactly equal two jump instructions) we get the following waveforms:
| ![jaalpipel](https://user-images.githubusercontent.com/43972902/115244586-5876b000-a124-11eb-8abf-412fd1ee9d04.png) |
|:--:|
| *Simulation in ModelSim of the above code for two jump iterations.* |

As previously: <br/>
First line is *clk*, clock cycle. <br/>
Second line is *rst*, reset. When the reset fall down, the processor can start working. Until the first instruction is executed (`addi x5, x0, 0`, machine code: *0x00000293*, time: 4 μs), the value of *x5* register (the last waveform) is undetermined, thanks to this we can see red line. It's very important. In the 4 μs we can see that processor is executing instruction *0x00000293* and after this processor will save to *x5* register value *0*. Not in the same time!! Processor will reset register only **after** execution instruction, in the next clock cycle. We can notice it in the waveforms. <br/>
In 7 μs we can see that *jal* saved to *x1* register return address (*12* in dec *0x0c* in hex). 

#### Pipelining for conditional jumps  <a name="pipeljump"></a> [UP↑](#tof)

| Address in PC | Instruction | Instruction after assembling | Equivalent machine code | 
|:--:|:--:|:--:|:--:|
|    |  start:  |    |    |
| 0x00 | addi x1, x0, 2 | addi x1, x0, 2 | 0x00200093 |
| 0x04 | addi x2, x0, 0 | addi x2, x0, 0 | 0x00000113 |
|  | loop: |  |  |
| 0x08 | add  x2, x2, x1 | add  x2, x2, x1 | 0x00110133 |
| 0x0c | addi x1, x1, -1 | addi x1, x1, -1 | 0xfff08093 |
| 0x10 | bne  x0, x1, loop | bne  x0, x1, -8 | 0xfe101ce3 |
| 0x14 | j start | jal  x0, -20 | 0xfedff06f |







