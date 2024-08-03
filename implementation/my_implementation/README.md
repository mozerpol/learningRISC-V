# RISCPOL
> Simple RISC-V (RV32I) core written in VHDL. Peripherals:
> - 8-bit Timer
> - UART
> - 8-bit GPIO

### Overview
Very simple single-stage RISC-V (RV32I) core for learning purposes (without 
SYSTEM instructions). It's written in VHDL. The aim of this project was to learn 
about RISC-V, for this reason the implementation is extremely simple, no 
pipelining, no interrupts, no branch prediction etc.

### Repository tree
```
my_implementation
|
|___riscpol_design.vhd
|___riscpol_diagram.drawio
|___riscpol_pkg.vhd
|___riscpol_tb.vhd
|
|___core
|   |___alu_design.vhd
|   |___alu_mux_1_design.vhd
|   |___alu_mux_2_design.vhd
|   |___branch_instructions_design.vhd
|   |___code.txt
|   |___control_design.vhd
|   |___control_pkg.vhd
|   |___core_design.vhd
|   |___decoder_design.vhd
|   |___instruction_memory_design.vhd
|   |___opcodes.vhd
|   |___program_counter_design.vhd
|   |___ram_management_design.vhd
|   |___reg_file_design.vhd
|   |___rom.vhd
|   |___rom_updater.py
|
|___peripherals
|   |___gpio_design.vhd
|   |___ram.vhd
|
|___script
|   |___script.tcl
|   |___waveforms.do
|
|___synthesis
|   |___riscpol.sdc
|
|___code_samples
|   |___general.asm
|   |___general.hex
|   |___gpio.asm
|   |___gpio.hex
```
The entire project is in the main *my_implementation* folder. The top design is
*riscpol_design.vhd* file, the top-level entity is *riscpol*. It integrates the
core and all peripherals, such as GPIO, UART and Timer. <br/>
The test for the top design is the *riscpol_tb.vhd*. All instructions used in
this test are in the *code_samples* folder in the files *general.asm* and
*general.hex*. <br/>
The main settings such as the size of memory for data or instructions are in the
*riscpol_pkg.vhd*. <br/>
A data path and a control path is in *core* folder. Additionally, there is a
python script that helps (but is not necessary) to update the instruction
memory. How to use it is described below. <br/>
The *peripherals* folder contains additional modules (e.g. Timer or UART) that
aren't necessary for the core, but helps a lot during creating own projects.<br/>
The *script* folder contains a TCL script that automates the simulation for
ModelSim in Linux. How to run it is described below. It is important to run the
script in the *script* folder. <br/>
The *synthesis* folder contains a file with timing constraints. <br/>
In the *code_samples* folder there are some sample programs. One file contains 
assembly language instructions (.asm extension), and the other contains the 
corresponding machine code instructions (.hex extension). The easiest way to 
translate assembly language into machine code is to use an online risc-v 
instruction decoder like [rvcodec.js](https://luplab.gitlab.io/rvcodecjs/).

### Simulation
To run simulation in ModelSim on Linux go to folder *script* and run command: 
`do script.tcl`<br/>
After running this command in ModelSim the simulation will start, end itself and 
show all signals on the waveforms. You can add your own signals to the waveforms 
by modifying the script/waveforms.do file. <br/>
For Windows systems you can try to modify the script/script.tcl to automate 
simulation. For other simulators (e.g. Vivado or GHDL) you have to do everything 
manually, i.e. add all files with the vhd extension, compile them and then run
tests which are in riscpol_tb.vhd file. <br/>
The top-level entity is riscpol in riscpol_design.vhd.

### Synthesis
There is no script to automate the synthesis. You have to do everything 
manually. Add all files with the vhd extension (without riscpol_tb.vhd, it's for 
testing purposes only) compile them and then run synthesis. <br/>
The top-level entity is riscpol in riscpol_design.vhd.

### Target platform
Resource utilization:
- Total logic elements: 1560,
- Total registers: 252,
- Total memory bits: 10240 (2048 for core, 8192 for RAM),
- Fmax: 55 MHz.

### Running your own program
File core/rom.vhd contains instructions to be executed, which are represented by 
32-bit hexadecimal code. Instructions can be manually edited by modifying C_CODE 
array. In a situation where are a lot of instructions, it's more convenient to 
paste them into the core/code.txt file, then go to folder *core* and run a 
python script by executing the command: `python3 rom_updater.py`, which will 
modify the C_CODE array. <br/>
There are two important rules for adding own instructions in rom.vhd file:
1. The last instruction in the C_CODE array must be: others => x"00000000" 
2. The size of the instruction memory is set in the riscpol_pkg.vhd file as a 
C_ROM_LENGTH constant.

### Datapath diagram
JPG: <br/>
![riscpol_diagram](https://github.com/user-attachments/assets/fad0b6aa-71c2-47c7-8cac-3e4552ad8efd)

SVG: <br/>
![riscpol_diagram](https://github.com/user-attachments/assets/f6d05e20-32ca-4529-8e74-41c2b9136173)

The *riscpol_diagram.drawio* file can be opened using flowchart maker. I used
*drawio* available at: https://app.diagrams.net/

### How it works, the dataflow
The processor should start with a reset. This will set all control signals and 
registers to their default values ​​and load the first instruction for execution.

#### Based on the ADD instruction
Przykładowa instrukcja: add x3, x2, x1 = 0x001101b3 <br/>

1. Podczas resetu na wyjscie sygnalu instruction w module instruction_memory przypisywana jest pierwsza instrukcja do wykonania z tablicy C_CODE, ktora jest w modoule rom.vhd. <br/>
instruction = 001101b3
2. Na pierwsze zbocze narastające po odpuszczeniu sygnału reset instrukcja trafia do modułu decode, a tam dzielona jest na poszczególne składowe w zależności od OPCODE. W każdej instrukcji można wyróżnic skladowe odpowiedzialne za sterowanie (np. OPCODE, który mówi z jaką instrukcją mamy do czynienia) oraz składowe danych, które są zwykłymi liczbami. Dla przykładowej instrukcji: <br/>
- rd_addr = 3
- rs1_addr = 1
- rs2_addr = 2
- imm = 0
- opcode = 33
- func3 = 0
- func7 = 0
3. Składowe sterujące z modułu dekoder idą do modułu control, który na ich podstawie zarządza wszystkimi modułami w rdzeniu. Natomiast składowe danych trafiają do register_file, alu_mux_2 oraz ram_management.
4. W zależności od OPCODE 

#### Based on the ADDI instruction

#### Based on the BNE instruction

#### Based on the SH instruction

### Might help

### Project status
1. Implementation of a three-stage processor:
- [ ] Fetch, decode, execute.
2. Protocols implementation
- [ ] 1-Wire,
- [ ] SPI,
- [ ] I2C,
- [ ] UART.
3. Others
- [ ] Add 8-bit timer,
- [ ] Add cache,
- [ ] Setup and run Dhrystone,
- [ ] Add script for Vivado and GHDL,
- [ ] Change name to single-stage and move part of readme there,
- [ ] Describe timign constraints,
- [ ] Add some helpful articles,
- [ ] Add gif (or maybe link to youtube) how to step by step run 
