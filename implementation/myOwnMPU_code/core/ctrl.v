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
  output wire reg_wr
  //   output instMgmtPkg::inst_sel inst_sel,
  //   output logic reg_wr,
  //   output aluPkg::alu_op alu_op,
  //   output cmpPkg::cmp_op cmp_op,
  //   output pcPkg::pc_sel pc_sel,
  //   output pcPkg::mem_sel mem_sel,
  //   output rdPkg::rd_sel rd_sel,
  //   output alu2Pkg::alu2_sel alu2_sel,
  //   output selectPkg::sel_type sel_type,
  //   output logic we
);

  reg next_nop;  
  reg load_phase;
  reg reg_wr_o;
  assign reg_wr = reg_wr_o;

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
  mem_addr_sel mem_addr_sel_ctrl(
    .pc_sel(pc_sel)
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

  always @(posedge clk)
    begin
      if (opcode == `LOAD)
        load_phase = ~load_phase;
      if (rst)
        load_phase <= 1'b0;
    end

endmodule
