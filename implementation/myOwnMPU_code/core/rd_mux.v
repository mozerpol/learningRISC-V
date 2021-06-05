/*
	How this module works...
    As we can see it's simple mux, which is control by "rd_sel". The output from this module
    goes to "reg_file" module to part "rd_d". Ok, it's very important, rd_d in reg_file is
    always 32-bit number which comes from:
    1. Program counter
    2. Output of ALU
    3. imm from decode module (precisely imm_I, imm_S, ...)
    4. rd from select_rd module
    So "rd_d" can be e.g. the result of operations from ALU.
*/
`include "rysy_pkg.v"
`timescale 100ns / 10ns

`define RD_IMM 	2'b00
`define RD_PCP4 2'b01
`define RD_ALU 	2'b10
`define RD_MEM 	2'b11

module rd_mux(
  input wire [`REG_LEN-1:0] imm, // From decode, can be imm_I, imm_J, ...
  input wire [`REG_LEN-1:0] pc, // From PC
  input wire [`REG_LEN-1:0] alu_out, // From ALU
  input wire [`REG_LEN-1:0] rd_mem, // From select_rd
  input wire clk,
  input wire [1:0] rd_sel, // for switch-case
  output wire [`REG_LEN-1:0] rd_d
);

  reg [`REG_LEN-1:0] o;
  assign rd_d = o;
  reg [`REG_LEN-1:0] old_pc;

  always@(posedge clk) old_pc <= pc; // In core structure we can see, that we have
  // one clock delay "z^-1". Thanks to this line we can execute this delay.

  always@(*)
    case(rd_sel)
      `RD_IMM : o = imm;
      `RD_PCP4: o = old_pc;
      `RD_ALU : o = alu_out;
      `RD_MEM : o = rd_mem;
    endcase
endmodule
