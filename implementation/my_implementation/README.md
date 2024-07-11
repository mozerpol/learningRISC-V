# RISCPOL
> Simple RISC-V (RV32I) core written in VHDL.

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
|___tests
|   |___general.asm
|   |___general.hex
|   |___gpio.asm
|   |___gpio.hex
```

### Simulation
To run simulation in ModelSim on Linux run command: `do script/script.tcl`<br/>
After running this command in ModelSim the simulation will start, end itself and 
show all signals on the waveforms. You can add your own signals to the waveforms 
by modifying the script/waveforms.do file. <br/>
For Windows systems you can try to modify the script/script.tcl to automate 
simulation. For other simulators (e.g. Vivado or GHDL) you have to do everything 
manually, i.e. add all files with the vhd extension, compile them and then run
tests which are in riscpol_tb.vhd file. <br/>
The top-level entity is riscpol in riscpol_design.vhd.

### Building
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
paste them into the core/code.txt file, and then run a python script by 
executing the command: `python3 core/rom_updater.py`, which will modify the 
C_CODE array. <br/>
There are two important rules:
1. The last instruction in the C_CODE array must be: others => x"00000000" 
2. The size of the instruction memory is set in the riscpol_pkg.vhd file as a 
C_ROM_LENGTH constant.

### Datapath diagram
JPG: <br/>
![riscpol_diagram](https://github.com/user-attachments/assets/2670cb64-670f-40ad-b2ff-b576a2e6af79)

SVG: <br/>
![riscpol_diagram](https://github.com/user-attachments/assets/c0e1d11f-9dae-4926-9ef4-0643a7859d51)

