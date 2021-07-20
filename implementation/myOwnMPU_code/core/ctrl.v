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
  output wire we
);

  reg next_nop;  
  reg load_phase;
  reg reg_wr_o;
  assign reg_wr = reg_wr_o;
  reg we_o;
  assign we = we_o;

  // ....:::::Controlling imm_mux:::::....
  reg [2:0] imm_type;
  imm_mux imm_mux_ctrl(
    .imm_type(imm_type)
  );

  always@(opcode)
    case (opcode)
      `OP_IMM:	imm_type = `IMM_I;
      `LUI: 	imm_type = `IMM_U;
      `JAL: 	imm_type = `IMM_J;
      `JALR: 	imm_type = `IMM_I;
      `BRANCH: 	imm_type = `IMM_B;
      `LOAD: 	imm_type = `IMM_I;
      `STORE: 	imm_type = `IMM_S;
      default: imm_type = `IMM_DEFAULT;
    endcase

  // ....:::::Controlling alu1_nux:::::....
  reg alu1_sel;
  alu1_mux alu1_mux_ctrl(
    .alu1_sel(alu1_sel)
  );  

  always@(opcode)
    case (opcode)
      `BRANCH, `JAL: 
        alu1_sel = `ALU1_PC;
      default: alu1_sel = `ALU1_RS;
    endcase

  // ....:::::Controlling alu2_nux:::::....
  reg alu2_sel;
  alu2_mux alu2_mux_ctrl(
    .alu2_sel(alu2_sel)
  ); 

  always@(opcode)
    case (opcode)
      `LOAD, `STORE, `BRANCH, `JALR, `JAL, `OP_IMM: 
        alu2_sel = `ALU2_IMM;
      `OP: alu2_sel = `ALU2_RS;
      default: alu2_sel = `ALU2_IMM;
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
  reg [1:0] rd_sel;
  rd_mux rd_mux_ctrl(
    .rd_sel(rd_sel)
  ); 

  always@(opcode)
    case (opcode)
      `OP_IMM, `OP : 
        rd_sel = `RD_ALU;
      `LUI: rd_sel = `RD_IMM;
      `JALR, `JAL : 
        rd_sel = `RD_PCP4;
      `LOAD: rd_sel = `RD_MEM;
      default: rd_sel = `RD_ALU;
    endcase
  // ....:::::Controlling mem_addr_sel pc_sel part:::::....
  reg [1:0] pc_sel;
  reg mem_sel;
  mem_addr_sel mem_addr_sel_ctrl(
    .pc_sel(pc_sel),
    .mem_sel(mem_sel)
  );

  always@(opcode, b, load_phase)
    case (opcode)
      `JALR, `JAL: pc_sel = `PC_ALU;
      `BRANCH: pc_sel = b ? `PC_ALU : `PC_P4;
      `STORE: pc_sel = `PC_OLD;
      `LOAD:
        case (load_phase)
          1'd0: pc_sel = `PC_M4;
          1'd1: pc_sel = `PC_P4;
          default: pc_sel = `PC_OLD;
        endcase
      default: pc_sel = `PC_P4;
    endcase


  // ....:::::Controlling mem_addr_sel mem_sel part:::::....
  // Binding of mem_sel var above
  always@(opcode, load_phase)
    case (opcode)
      `STORE: mem_sel = `MEM_ALU;
      `LOAD:
        case(load_phase)
          1'd0: mem_sel = `MEM_ALU;
          default: mem_sel = `MEM_PC;
        endcase
      default: mem_sel = `MEM_PC;
    endcase

  // ....:::::Controlling cmp:::::....
  reg [2:0] cmp_op;
  cmp cmp_ctrl(
    .cmp_op(cmp_op)
  ); 

  always@(*)
    case(func3)
      `FUNC3_BRANCH_BEQ: 	cmp_op = `EQ;
      `FUNC3_BRANCH_BNE: 	cmp_op = `NE;
      `FUNC3_BRANCH_BLT: 	cmp_op = `LT;
      `FUNC3_BRANCH_BGE:	cmp_op = `GE;
      `FUNC3_BRANCH_BLTU: 	cmp_op = `LTU;
      `FUNC3_BRANCH_BGEU:	cmp_op = `GEU;
      default: cmp_op = `EQ;
    endcase

  // ....:::::Controlling select_pkg:::::....
  reg [2:0] sel_type;

  always@(func3, opcode)
    case(func3)
      `FUNC3_SB:	sel_type = `SB;
      `FUNC3_SH: 	sel_type = `SH;
      `FUNC3_SW: 	sel_type = `SW;
      `FUNC3_SBU: 	sel_type = `SBU;
      `FUNC3_SHU: 	sel_type = `SHU;
      default: sel_type = `SW;
    endcase

  // ....:::::Controlling inst_mgm:::::....
  reg [1:0] inst_sel;
  inst_mgmt inst_mgmt_ctrl(
    .inst_sel(inst_sel)
  );

  always@(next_nop, opcode, b, load_phase)
    if(next_nop)
      inst_sel = `INST_NOP;
  else
    case(opcode)
      `JALR, `JAL: inst_sel = `INST_NOP;
      `BRANCH: inst_sel = b ? `INST_NOP : `INST_MEM;
      `LOAD:
        case (load_phase)
          1'd1: inst_sel = `INST_NOP;
          default: inst_sel = `INST_OLD;
        endcase
      default: inst_sel = `INST_MEM;
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
  reg [3:0] alu_op;
  alu alu_ctrl(
    .alu_op(alu_op)
  );

  always@(opcode, func3, func7)	
    case(opcode) // Argument has five bits
      `OP_IMM, `OP: // 5'b00100 for OP_IMM or 5'b01100 for OP
        case(func3)
          `FUNC3_ADD_SUB: // 3'b000, func3 for ADD and SUB is the same, func7 is the difference
            if((opcode == `OP) && (func7 == `FUNC7_ADD_SUB_SUB)) // 7'b0100000
              alu_op = `SUB; // 4'b0001
          else alu_op = `ADD; // 4'b0000
          `FUNC3_SLT : alu_op = `SLT; // 3'b010, 4'b1000
          `FUNC3_SLTU: alu_op = `SLTU;// 3'b011, 4'b1001
          `FUNC3_XOR : alu_op = `XOR; // 3'b100, 4'b0010
          `FUNC3_OR  : alu_op = `OR;  // 3'b110, 4'b0011
          `FUNC3_AND : alu_op = `AND; // 3'b111, 4'b0100
          `FUNC3_SLL : alu_op = `SLL; // 3'b001, 4'b0101
          `FUNC3_SR  : // 3'b101
            case(func7) // each instruction from R-format has a func7 field, but in previous
              // cases we eliminated some instructions and left only SRL and SRA. The only one
              // difference between this two instructions is func7 field. 
              // SRA = 0100000 <seven bits>
              // SRL = 0000000
              `FUNC7_SR_SRL : alu_op = `SRL;
              `FUNC7_SR_SRA : alu_op = `SRA;
              default: alu_op = `ADD;
            endcase
          default: alu_op = `ADD;
        endcase // end case(func3)
      `LOAD, `STORE, `BRANCH,
      `JAL, `JALR : alu_op = `ADD;
      default: alu_op = `ADD;
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
