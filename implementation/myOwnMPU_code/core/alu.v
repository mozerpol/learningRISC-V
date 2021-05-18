`include "rysy_pkg.vh"
`timescale 1ns / 1ns

module alu(
  input  [`REG_LEN-1:0] alu_in1,
  input  [`REG_LEN-1:0] alu_in2,
  input  [3:0] alu_op,
  output reg [`REG_LEN-1:0] alu_out
);

  always@(alu_out, alu_in1, alu_in2) begin
    case(alu_op)
      2'b00 : alu_out = alu_in1 + alu_in2;
      2'b01 : alu_out = alu_in1 - alu_in2;
    endcase
  end

endmodule
