/*
 * Mozerpol 2021
 */

`include "rysy_pkg.vh"
`timescale 100ns / 10ns

`define ALU2_RS 0
`define ALU2_IMM 1

module alu2_mux (
  input wire [`REG_LEN-1:0] rs2_d,
  input wire [`REG_LEN-1:0] imm,
  input wire alu2_sel,
  output wire [`REG_LEN-1:0] alu_in2
);
  
  reg [`REG_LEN-1:0] o;
  assign alu_in2 = o;
  
  always@(*)
    begin
      case(alu2_sel)
        `ALU2_RS : o = rs2_d;
        `ALU2_IMM : o = imm;
      endcase
    end
  
endmodule
