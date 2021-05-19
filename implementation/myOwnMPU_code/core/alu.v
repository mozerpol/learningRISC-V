`include "rysy_pkg.vh"
`timescale 100ns / 10ns

`define ADD 4'b0000
`define SUB 4'b0001
`define XOR 4'b0010
`define OR  4'b0011
`define AND 4'b0100
`define SLL 4'b0101
`define	SRL 4'b0110
`define	SRA 4'b0111
`define SLT 4'b1000
`define SLTU 4'b1001

module alu(
  input wire [`REG_LEN-1:0] alu_in1,
  input wire [`REG_LEN-1:0] alu_in2,
  input wire [3:0] alu_op,
  output wire [`REG_LEN-1:0] alu_out
);

  reg signed [`REG_LEN-1:0] o;
  reg signed [`REG_LEN-1:0] alu_in1_s;
  reg signed [`REG_LEN-1:0] alu_in2_s;
  
  assign alu_out = o;
  assign alu_in1_s = alu_in1;
  assign alu_in2_s = alu_in2;

  always@(alu_out, alu_in1, alu_in2) begin
    case(alu_op)
      `ADD : o = alu_in1 + alu_in2;
      `SUB : o = alu_in1 - alu_in2;
      `XOR : o = alu_in1 ^ alu_in2;
      `OR  : o = alu_in1 | alu_in2;
      `AND : o = alu_in1 & alu_in2;
      `SLL : o = alu_in1 << alu_in2[4:0];
      `SRL : o = alu_in1 >> alu_in2[4:0];
      `SRA : o = alu_in1_s >>> alu_in2_s[4:0];
      `SLT : o = alu_in1_s < alu_in2_s;
      `SLTU : o = alu_in1 < alu_in2;
      default: o = 0;
    endcase
  end

endmodule
