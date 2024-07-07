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

