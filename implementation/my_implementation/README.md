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

