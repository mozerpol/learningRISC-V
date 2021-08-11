`timescale 100ns / 10ns

`include "rysy_pkg.vh"
`include "imm_mux.vh"

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

  always@(*)
    begin
      case(imm_type)
        `IMM_J : o = imm_J;
        `IMM_U : o = imm_U;
        `IMM_B : o = imm_B;
        `IMM_S : o = imm_S;
        `IMM_I : o = imm_I;
        default: o = 0;
      endcase
    end

endmodule

/*
	The operation of this module is very simple, just select appropriate imm_type (like J, U, ...)
    and give a signal from input to output.
*/
