/*
	By Mozerpol
*/

`timescale 100ns / 10ns

`include "rysy_pkg.vh"
`include "opcodes.vh"
`include "inst_mgmt.v"
`include "imm_mux.v"
`include "alu.v"
`include "cmp.v"
`include "mem_addr_sel.v"
`include "rd_mux.v"
`include "alu1_mux.v"
`include "alu2_mux.v"
`include "select_pkg.v"

module ctrl(
  input wire clk,
  input wire rst,
  input wire [4:0] opcode,
  input wire [2:0] func3,
  input wire [6:0] func7,
  input wire b,
  output wire reg_wr,
  output wire we,
  output wire [2:0] imm_type,
  output wire alu1_sel,
  output wire alu2_sel,
  output wire [1:0] rd_sel,
  output wire [1:0] pc_sel,
  output wire mem_sel,
  output wire [2:0] cmp_op,
  output wire [2:0] sel_type,
  output wire [1:0] inst_sel,
  output wire [3:0] alu_op
);

  reg next_nop;  
  reg load_phase;
  reg reg_wr_o;
  assign reg_wr = reg_wr_o;
  reg we_o;
  assign we = we_o;

  // ....:::::Controlling imm_mux:::::....
  reg [2:0] imm_type_reg;
  assign imm_type = imm_type_reg;

  always@(opcode)
    case (opcode)
      `OP_IMM:	imm_type_reg = `IMM_I;
      `LUI: 	imm_type_reg = `IMM_U;
      `JAL: 	imm_type_reg = `IMM_J;
      `JALR: 	imm_type_reg = `IMM_I;
      `BRANCH: 	imm_type_reg = `IMM_B;
      `LOAD: 	imm_type_reg = `IMM_I;
      `STORE: 	imm_type_reg = `IMM_S;
      default: imm_type_reg = `IMM_DEFAULT;
    endcase

  // ....:::::Controlling alu1_nux:::::....
  reg alu1_sel_reg;
  assign alu1_sel = alu1_sel_reg;

  always@(opcode)
    case (opcode)
      `BRANCH, `JAL: 
        alu1_sel_reg = `ALU1_PC;
      default: alu1_sel_reg = `ALU1_RS;
    endcase

  // ....:::::Controlling alu2_nux:::::....
  reg alu2_sel_reg;
  assign alu2_sel = alu2_sel_reg;


  always@(opcode)
    case (opcode)
      `LOAD, `STORE, `BRANCH, `JALR, `JAL, `OP_IMM: 
        alu2_sel_reg = `ALU2_IMM;
      `OP: alu2_sel_reg = `ALU2_RS;
      default: alu2_sel_reg = `ALU2_IMM;
    endcase

  // ....:::::Controlling reg_wr from reg_file module:::::.... 
  always@(opcode, load_phase)
    case (opcode)
      `JALR, `JAL, `OP_IMM, `LUI, `OP : 
        reg_wr_o = 1'b1;
      `LOAD: reg_wr_o = load_phase;
      default: reg_wr_o = 1'b0;
    endcase

  // ....:::::Controlling rd_mux:::::....
  reg [1:0] rd_sel_reg;
  assign rd_sel = rd_sel_reg;

  always@(opcode)
    case (opcode)
      `OP_IMM, `OP : 
        rd_sel_reg = `RD_ALU;
      `LUI: rd_sel_reg = `RD_IMM;
      `JALR, `JAL : 
        rd_sel_reg = `RD_PCP4;
      `LOAD: rd_sel_reg = `RD_MEM;
      default: rd_sel_reg = `RD_ALU;
    endcase
  
  // ....:::::Controlling mem_addr_sel pc_sel part:::::....
  reg [1:0] pc_sel_reg;
  assign pc_sel = pc_sel_reg;
  reg mem_sel_reg;
  assign mem_sel = mem_sel_reg;

  always@(opcode, b, load_phase)
    case (opcode)
      `JALR, `JAL: pc_sel_reg = `PC_ALU;
      `BRANCH: pc_sel_reg = b ? `PC_ALU : `PC_P4;
      `STORE: pc_sel_reg = `PC_OLD;
      `LOAD:
        case (load_phase)
          1'd0: pc_sel_reg = `PC_M4;
          1'd1: pc_sel_reg = `PC_P4;
          default: pc_sel_reg = `PC_OLD;
        endcase
      default: pc_sel_reg = `PC_P4;
    endcase


  // ....:::::Controlling mem_addr_sel mem_sel part:::::....
  // Binding of mem_sel var above
  always@(opcode, load_phase)
    case (opcode)
      `STORE: mem_sel_reg = `MEM_ALU;
      `LOAD:
        case(load_phase)
          1'd0: mem_sel_reg = `MEM_ALU;
          default: mem_sel_reg = `MEM_PC;
        endcase
      default: mem_sel_reg = `MEM_PC;
    endcase

  // ....:::::Controlling cmp:::::....
  reg [2:0] cmp_op_reg = 3'b000;
  assign cmp_op = cmp_op_reg;

  always@(*)
    case(func3)
      `FUNC3_BRANCH_BEQ: 	cmp_op_reg = `EQ;
      `FUNC3_BRANCH_BNE: 	cmp_op_reg = `NE;
      `FUNC3_BRANCH_BLT: 	cmp_op_reg = `LT;
      `FUNC3_BRANCH_BGE:	cmp_op_reg = `GE;
      `FUNC3_BRANCH_BLTU: 	cmp_op_reg = `LTU;
      `FUNC3_BRANCH_BGEU:	cmp_op_reg = `GEU;
      default: cmp_op_reg = `EQ;
    endcase

  // ....:::::Controlling select_pkg:::::....
  reg [2:0] sel_type_reg;
  assign sel_type = sel_type_reg;

  always@(func3, opcode)
    case(func3)
      `FUNC3_SB:	sel_type_reg = `SB;
      `FUNC3_SH: 	sel_type_reg = `SH;
      `FUNC3_SW: 	sel_type_reg = `SW;
      `FUNC3_SBU: 	sel_type_reg = `SBU;
      `FUNC3_SHU: 	sel_type_reg = `SHU;
      default: sel_type_reg = `SW;
    endcase

  // ....:::::Controlling inst_mgm:::::....
  reg [1:0] inst_sel_reg;
  assign inst_sel = inst_sel_reg;

  always@(next_nop, opcode, b, load_phase)
    if(next_nop)
      inst_sel_reg = `INST_NOP;
  else
    case(opcode)
      `JALR, `JAL: inst_sel_reg = `INST_NOP;
      `BRANCH: inst_sel_reg = b ? `INST_NOP : `INST_MEM;
      `LOAD:
        case (load_phase)
          1'd1: inst_sel_reg = `INST_NOP;
          default: inst_sel_reg = `INST_OLD;
        endcase
      default: inst_sel_reg = `INST_MEM;
    endcase  
  /*
   ....:::::Controlling ALU:::::....

   How part below works:
   1. switch(opcode): - in this module we are considering only two types of instrucions: 
   	  I-type (OP-IMM family) and R-type (OP family). This types has the same ammount of 
      instructions and they have ADD, ADDI, AND, ANDI, ...
      So we can divide this part on two modules, one for I-type, second for R-type, but this 
      approach will be longer. The difference between this types is opcode and in some cases
      func7 part, some instructions just have it and some don't. So the differences between 
      instructions are: opcode, func3 and func7. Thanks to this we can just recognize this
      differences and assign output from this module (alu_op - it decides which istruction 
      ALU will perform) to the input of ALU. This output
      selects the instruction to use.
    case(OP_IMM & OP) - I-type instruction family (OM-IMM) such as: ADDI, ANDI, SLLI, ...
                        R-type instruction family (OP) such as ADD, AND, SLL, ...
    case (LOAD & STORE & BRANCH & JAL & JALR & ADD) -
   	1_1. switch(func3):
   	1_2. switch(func7):
  */
  reg [3:0] alu_op_reg;
  assign alu_op = alu_op_reg;

  always@(opcode, func3, func7)	
    case(opcode) // Argument has five bits
      `OP_IMM, `OP: // 5'b00100 for OP_IMM or 5'b01100 for OP
        case(func3)
          `FUNC3_ADD_SUB: // 3'b000, func3 for ADD and SUB is the same, func7 is the difference
            if((opcode == `OP) && (func7 == `FUNC7_ADD_SUB_SUB)) // 7'b0100000
              alu_op_reg = `SUB; // 4'b0001
          else alu_op_reg = `ADD; // 4'b0000
          `FUNC3_SLT : alu_op_reg = `SLT; // 3'b010, 4'b1000
          `FUNC3_SLTU: alu_op_reg = `SLTU;// 3'b011, 4'b1001
          `FUNC3_XOR : alu_op_reg = `XOR; // 3'b100, 4'b0010
          `FUNC3_OR  : alu_op_reg = `OR;  // 3'b110, 4'b0011
          `FUNC3_AND : alu_op_reg = `AND; // 3'b111, 4'b0100
          `FUNC3_SLL : alu_op_reg = `SLL; // 3'b001, 4'b0101
          `FUNC3_SR  : // 3'b101
            case(func7) // each instruction from R-format has a func7 field, but in previous
              // cases we eliminated some instructions and left only SRL and SRA. The only one
              // difference between this two instructions is func7 field. 
              // SRA = 0100000 <seven bits>
              // SRL = 0000000
              `FUNC7_SR_SRL : alu_op_reg = `SRL;
              `FUNC7_SR_SRA : alu_op_reg = `SRA;
              default: alu_op_reg = `ADD;
            endcase
          default: alu_op_reg = `ADD;
        endcase // end case(func3)
      `LOAD, `STORE, `BRANCH,
      `JAL, `JALR : alu_op_reg = `ADD;
      default: alu_op_reg = `ADD;
    endcase // end case(opcode)

  // ....::::::::::....
  always@(posedge clk) 
    begin
      if(rst)
        next_nop = 1'b1; // Prevent first inst of being processed twice.
      else if ((opcode == `JAL) || (opcode == `JALR) ||
               ((opcode == `BRANCH) && b) || (opcode == `STORE))
        next_nop = 1'b1;
      else
        next_nop = 1'b0;
    end

  // ....::::::::::....
  always @(posedge clk)
    begin
      if (opcode == `LOAD)
        load_phase = ~load_phase;
      if (rst)
        load_phase <= 1'b0;
    end

  // ....::::::::::....
  always@(opcode)
    case (opcode)
      `STORE: we_o = 1'b1;
      default: we_o = 1'b0;
    endcase

endmodule
