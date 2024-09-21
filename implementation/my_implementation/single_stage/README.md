# RISCPOL
> Implementation of a simple single-stage pipeline for the RISC-V core (RV32I) 
written in VHDL. Features include:
> - 8-bit Timer
> - UART
> - 8-bit GPIO
> - xxMHz clock
> - Up to XXMIPS throughput at XXMHz

### Overview
Very simple single-stage RISC-V (RV32I) core for learning purposes (without
SYSTEM instructions). It's written in VHDL. The aim of this project was to learn
about RISC-V, for this reason the implementation is extremely simple, no
pipelining, no interrupts, no branch prediction etc.

### Repository tree
```
single_stage
|
|___riscpol_design.vhdl
|___riscpol_diagram.drawio
|___riscpol_pkg.vhdl
|___riscpol_tb.vhdl
|
|___core
|   |___alu_design.vhdl
|   |___alu_mux_1_design.vhdl
|   |___alu_mux_2_design.vhdl
|   |___branch_instructions_design.vhdl
|   |___code.txt
|   |___control_design.vhdl
|   |___control_pkg.vhdl
|   |___core_design.vhdl
|   |___decoder_design.vhdl
|   |___instruction_memory_design.vhdl
|   |___opcodes.vhdl
|   |___program_counter_design.vhdl
|   |___ram_management_design.vhdl
|   |___reg_file_design.vhdl
|   |___rom.vhdl
|   |___rom_updater.py
|
|___peripherals
|   |___gpio_design.vhdl
|   |___ram.vhdl
|
|___simulation_script
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
The entire project is in the main *single_stage* folder. The top design is
*riscpol_design.vhdl*, the top-level entity is *riscpol*. It integrates the core
and all peripherals, such as GPIO, UART and Timer. <br/>
The test for the top design is the *riscpol_tb.vhdl*. All instructions used in
this test are in the *code_samples* folder in the files *general.asm* and
*general.hex*. <br/>
The main settings such as the size of data memory or instruction memory are in
the *riscpol_pkg.vhdl*. <br/>
The data path and the control path is in *core* folder. Additionally, there is a
python script that helps (but is not necessary) to update the instruction
memory. How to use this script is described below. <br/>
The *peripherals* folder contains additional modules (e.g. Timer or UART), that
aren't necessary for the core, but helps a lot during creating own projects.<br/>
The *simulation_script* folder contains a TCL script that automates the
simulation for ModelSim in Linux. How to run it is described below. It is
important to run the script in the *simulation_script* folder. <br/>
The *synthesis* folder contains a file with timing constraints. <br/>
In the *code_samples* folder are sample programs. One file contains assembly
language instructions (.asm extension), and the other contains the corresponding
machine code instructions (.hex extension). For me the easiest way to translate
assembly language into machine code is to use an online risc-v instruction
decoder like [rvcodec.js](https://luplab.gitlab.io/rvcodecjs/).

### Simulation
I described how to run scripts that will automatically start simulation for
GHDL, ModelSim or Vivado in *single_stage/simulation_script/README.md*.

### Synthesis
There is no script to automate the synthesis. You have to do everything
manually. The top-level entity is *riscpol* in *riscpol_design.vhdl*.

### Target platform
Resource utilization:
- Total logic elements: 1560,
- Total registers: 252,
- Total memory bits: 10240 (2048 for core, 8192 for RAM),
- Fmax: 55 MHz.

### Running your own program
It is described in the main README (on the previous page).

### Datapath diagram
JPG: <br/>
![riscpol_diagram](https://github.com/user-attachments/assets/fad0b6aa-71c2-47c7-8cac-3e4552ad8efd)

SVG: <br/>
![riscpol_diagram](https://github.com/user-attachments/assets/f6d05e20-32ca-4529-8e74-41c2b9136173)

The *riscpol_diagram.drawio* file can be opened using flowchart maker. I used
*drawio* available at: https://app.diagrams.net/

### How it works, the dataflow
The processor should start with a reset. This will set all control signals and
registers to their default values and load the first instruction for execution.

**Explanation based on the ADD instruction** <br/>
Example instruction: add x3, x2, x1 = 0x001101b3. First the instruction is
fetched from the instruction memory, then decoded, the appropriate data is
fetched from the register file, data is added, and write back to the register
file. Everything will be done in one clock cycle.
1. During the reset, the first instruction to be executed from the *C_CODE*
array is loaded to the *instruction_memory* module. The *C_CODE* array is in the
*rom.vhdl* file. Loaded instruction is assigned to the output signal
(*instruction* signal) in the *instruction_memory* module. This is handled by
the following code:
```VHDL
if (i_rst = '1') then
   o_instruction  <= C_CODE(0);
```
2. On the first rising clock edge after releasing the reset signal, the
instruction goes to the *decoder* module, where it is divided into individual
parts depending on the opcode (the opcode tells us what instruction we are
dealing with). In each instruction, we can distinguish parts responsible for
control (e.g. the opcode, func3, func7) and data parts, which are numbers. For
our example instruction, the output from the decode module is:
- rd_addr = 3
- rs1_addr = 1
- rs2_addr = 2
- imm = 0
- opcode = 33
- func3 = 0
- func7 = 0 <br/><br/>Code responsible for decoding instruction, case for ADD:
```VHDL
when C_OPCODE_OP  =>
   o_rd_addr   <= i_instruction(11 downto 7);
   o_rs1_addr  <= i_instruction(19 downto 15);
   o_rs2_addr  <= i_instruction(24 downto 20);
   o_imm       <= (others => '0');
   o_opcode    <= i_instruction(6 downto 0);
   o_func3     <= i_instruction(14 downto 12);
   o_func7     <= i_instruction(31 downto 25);
```

3. Signals responsible for data from the *decoder* module (such as *imm*,
*rd_addr*, *rs1_addr* and *rs2_addr*) go to the *register_file*, *alu_mux_2* and
*ram_management*. These modules will be described later. <br/>
Control signals from the *decoder* module (such as *opcode*, *func3* and
*func7*) go to the *control_module*, which uses them to manage all other modules
in the core:
- The ALU is controlled via the *alu_control* signal. In our case, for the
opcode value 33 (constant C_OPCODE_OP) the value 0 (constant C_ADD) is
transferred. Thanks to this, ALU knows that in this case it should add two
operands. Part of the *control* module, which is responsible for controlling
*alu* in case of ADD instruction:
```VHDL
if (i_rst = '1') then
   o_alu_control     <= (others => '0');
else
   case i_opcode(6 downto 0) is
      when C_OPCODE_OP =>
         case i_func3 is
            when C_FUNC3_ADD_SUB =>
               if (i_func7 = C_FUNC7_SUB) then
                  o_alu_control <= C_SUB;
               else
                  o_alu_control <= C_ADD;
               end if;
```
- the *alu_mux_1* and *alu_mux_2* modules are controlled via the
*alu_mux_1_ctrl* and *alu_mux_2_ctrl* signals, which are assigned the value 0
(constant C_RS1_DATA and C_RS2_DATA). The alu_mux_1 and alu_mux_2 modules will
be described later. Part of the code from the *control* module, which is
responsible for controlling *alu_mux_1* and *alu_mux_2*:
```VHDL
p_alu_mux : process (i_rst, i_opcode)
begin
   if (i_rst = '1') then
      o_alu_mux_1_ctrl     <= C_RS1_DATA;
      o_alu_mux_2_ctrl     <= C_RS2_DATA;
   else
      case i_opcode(6 downto 0) is
         when C_OPCODE_OP     =>
            o_alu_mux_1_ctrl     <= C_RS1_DATA;
            o_alu_mux_2_ctrl     <= C_RS2_DATA;
```
- the *register_file* module is controlled via the *reg_file_inst_ctrl* signal,
which is assigned the value 0 (constant C_WRITE_ALU_RESULT). The
*register_file* will be described later.

4. The *alu_mux_1* and *alu_mux_2* modules are multiplexers. They are
responsible for transferring the appropriate data to the ALU. In this case (ADD
instruction), they both transfer data from the *register_file*, which were
located in registers x1 and x2. A process from the *alu_mux_1* module that
selects the appropriate data to be passed to the ALU:
```VHDL
p_alu_mux_1 : process(i_alu_mux_1_ctrl, i_rs1_data, i_pc_addr)
begin
   case i_alu_mux_1_ctrl is
      when C_RS1_DATA   => o_alu_operand_1 <= i_rs1_data;
      when C_PC_ADDR    => o_alu_operand_1 <= i_pc_addr;
      when others       => o_alu_operand_1 <= (others => '0');
   end case;
end process p_alu_mux_1;
```

5. The signal (*alu_control*) coming from the *control* module selects the
appropriate instruction to be executed in the ALU. In case of ADD the
*alu_control* signal has value 0. The part of the ALU code that is responsible
for adding two operands:
```VHDL
case i_alu_control is
   when C_ADD | C_ADDI  =>
      o_alu_result <= i_alu_operand_1 + i_alu_operand_2;
```

6. The *register_file* module is a 32-bit register of 32 cells, to which data
can be written and read. Reading is done asynchronously, depending on the
*rs1_addr* and *rs2_addr* values, which come from the decoder module. The read
value is assigned to the *rs1_data* and *rs2_data* output signals. For the ADD
instruction, the *rs1_data* and *rs2_data* signals are passed to the ALU. ALU
add them and send the result back as a *alu_result*. After that *register_file*
save this value in one of its cells indicated by signal *rd_addr*. Data writing
is done synchronously - it depends on the clock signal (*clk*).
Reading and writing process in *register_file*:
```VHDL
o_rs1_data <= (others => '0') when i_rs1_addr = "00000" else
              gpr(to_integer(unsigned(i_rs1_addr)));
o_rs2_data <= (others => '0') when i_rs2_addr = "00000" else
              gpr(to_integer(unsigned(i_rs2_addr)));

p_reg_file : process(i_clk)
begin
   if (i_clk'event and i_clk = '1') then
      -- Save data from RAM in GPR
      if (i_reg_file_inst_ctrl = C_WRITE_RD_DATA) then
         gpr(to_integer(unsigned(i_rd_addr))) <= i_rd_data;
      -- Save data from ALU in GPR
      elsif (i_reg_file_inst_ctrl = C_WRITE_ALU_RESULT) then
         gpr(to_integer(unsigned(i_rd_addr))) <= i_alu_result;
      else
      -- Save program counter value in GPR
         gpr(to_integer(unsigned(i_rd_addr))) <= i_pc_addr + 4;
      end if;
   end if;
end process p_reg_file;
```
7. All instructions must complete within one clock cycle. During each rising
clock edge, the program counter value is incremented by 4. Why 4? This is
according to the documentation. The program counter uses the *instruction_addr*
output signal to point to the instruction that will be currently executed.
Signal *instruction_addr* goes to the *instruction_memory* module. By
manipulating the program counter value, you can jump to any instruction in
memory.
