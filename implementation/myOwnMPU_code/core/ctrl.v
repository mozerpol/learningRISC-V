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
  input wire b
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
  
endmodule
