`include "rysy_pkg.vh"
`timescale 100ns / 10ns

`define	IMM_J 3'b000
`define IMM_U 3'b001
`define IMM_B 3'b010
`define IMM_S 3'b011
`define IMM_I 3'b100
`define IMM_DEFAULT 3'b101

module imm_mux(
  input wire [2:0]imm_type,
  input wire [`REG_LEN-1:0] imm_J,
  input wire [`REG_LEN-1:0] imm_U,
  input wire [`REG_LEN-1:0] imm_B,
  input wire [`REG_LEN-1:0] imm_S,
  input wire [`REG_LEN-1:0] imm_I,
  output wire [`REG_LEN-1:0] imm
);

  reg [`REG_LEN-1:0] o;
  assign imm = o;

  always@(imm_type)
    begin
      case(imm_type)
        `IMM_J : o = imm_J;
        `IMM_U : o = imm_U;
        `IMM_B : o = imm_B;
        `IMM_S : o = imm_S;
        `IMM_I : o = imm_I;
       // default: imm = 0;
      endcase
    end

endmodule


