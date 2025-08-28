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

### Memory map

Memory map:

|Address range (hexadecimal)|Size|Device|
|:--:|:--:|:--:|
|0000 - 003D|c|RAM|
||||


### Project status
1. Implementation of a three-stage processor:
- [ ] Fetch, decode, execute.
2. Protocols and modules implementation
- [x] UART,
- [ ] 1-Wire,
- [ ] SPI,
- [ ] I2C,
- [ ] 4x7-segment,
- [ ] HD44780,
- [ ] ADC,
- [ ] ECC module,
- [ ] simple sd card controller,
- [ ] cache,
- [ ] DMA controller.
3. Others
- [x] add 8-bit timer,
- [x] change name to single-stage and move part of readme there,
- [x] change vhd to vhdl,
- [x] fix GPIO, it's good to read from them :P
- [x] fix tests, maybe after some clock cycles (second reset) can check the last
instructions,
- [x] clean gitignore,
- [x] fix signal names,
- [x] fix flowchart,
- [x] change to negative reset,
- [x] split ram_management, there is for ram and program counter, it doesn't
      make any sense,
- [x] change name from script.tcl to run_simulation.tcl,
- [x] change ram_management to data_memory
- [ ] setup and run Dhrystone,
- [ ] add script for Vivado and GHDL,
- [ ] describe timing constraints,
- [ ] add some helpful articles - but very short!!!,
- [ ] add gif (or maybe link to youtube) how to step by step run project in
quartus,
- [ ] add timer with configurable width (timer ov output?),
- [ ] finish tests and clean them, describe as well. Firstly LUI, then ADDI
      should run,
- [ ] remove test_point => set_test_point from procedure, try to make test_point
  a global variable, thx to this procedure will be shorter,
- [ ] crate a new packet testbench_procedures.vhdl and put there all procedures,
      in this file,
- [ ] change 7 seg display module. i_7segment_wdata(31:0) shuld change only
      state of the output. I mean output of the i_7segment_wdata shoudl be
      directly assigned to the input of the 7 seg display. Not that it is
      convert to a number... Its odd. Then write tests for this module,
- [ ] add a separate folder: Documentation and put there README and drawio,
- [ ] add info, that vivado and modelsim have to be in PATH - modify .bashrc,
- [ ] in single_stage directory should be only files like flowchart, readme,
      License, etc.,
- [ ] add a sample system memory map table like here:
    https://en.wikipedia.org/wiki/Memory-mapped_I/O_and_port-mapped_I/O#Examples
- [ ] add documentation with table with instruction formats, and instructions...
