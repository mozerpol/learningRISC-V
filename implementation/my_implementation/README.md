# RISCPOL
> Simple RISC-V (RV32I) core written in VHDL. Features:
> - 8-bit Timer
> - UART
> - 8-bit GPIO
> - Up to xxMHz clock for single-stage pipeline implementation
> - Up to xxMHz clock for three-stage pipeline implementation
> - Up to XXMIPS throughput at XXMHz for single-stage pipeline implementation
> - Up to XXMIPS throughput at XXMHz for three-stage pipeline implementation

### Overview
There are two implementations of a simple RISC-V (RV32I) core. Single-stage 
implementation and three-stage implementation. Both are written in VHDL. The aim 
of this project was to learn about RISC-V, for this reason the implementations 
are extremely simple, no interrupts, no branch prediction, no SYSTEM
instructions, etc.

### Simulation
I described how to run scripts that will automatically start simulation for
GHDL, ModelSim or Vivado in *simulation_script/README.md*. The scripts are not 
necessary, but they make life easier. Without scripts you have to do everything 
manually, i.e. add all files with the vhdl extension, compile them and then run 
tests which are in *riscpol_tb.vhdl* file. The top-level entity is *riscpol* in 
*riscpol_design.vhdl*.

### Synthesis
There is no script to automate the synthesis. You have to do everything
manually. Add all files with the vhdl extension (without *riscpol_tb.vhdl*, it's
for testing purposes only) compile them and then run synthesis. <br/>
The top-level entity is *riscpol* in *riscpol_design.vhdl*.

### Running your own program
File *core/rom.vhdl* contains instructions to be executed, which are represented
by 32-bit hexadecimal code. Instructions can be manually edited by modifying
*C_CODE* array. In a situation where are a lot of instructions, it's more
convenient to paste them into the *core/code.txt* file, then go to folder *core*
and run a python script by executing the command: `python3 rom_updater.py`,
which will automatically modify the *C_CODE* array. <br/>
There are two important rules for adding own instructions in *rom.vhdl* file:
1. The last instruction in the *C_CODE* array must be: others => x"00000000"
2. The size of the instruction memory is set in the *riscpol_pkg.vhdl* file as a
*C_ROM_LENGTH* constant.

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
- [ ] add 8-bit timer,
- [ ] add cache,
- [ ] setup and run Dhrystone,
- [ ] add script for Vivado and GHDL,
- [x] change name to single-stage and move part of readme there,
- [ ] describe timing constraints,
- [ ] add some helpful articles,
- [ ] add gif (or maybe link to youtube) how to step by step run project in
quartus,
- [x] change vhdl to vhdl,
- [x] change script to simulation_script,
- [ ] fix GPIO, it's good to read from them :P
- [x] fix tests, maybe after some clock cycles (second reset) can check the last
instructions,
- [x] clean gitignore,
- [ ] add info, that vivado and modelsim have to be in PATH - modify .bashrc,
- [ ] in single_stage directory should be only files like flowchart, readme,
    License, etc.,
- [ ] fix signal names,
- [ ] fix flowchart,
- [ ] change to negative reset
