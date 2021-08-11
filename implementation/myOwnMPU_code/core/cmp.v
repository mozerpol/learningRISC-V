/*
 * Mozerpol
 * It is a simple ALU for comparing operations
 This ALU can take two operators:
 1. rs1_d from reg_file module. 
 2. rs2_d from reg_file module.
 So we can just say that this ALU compares two simple numbers.
 We have also third input, uses to select the type of operation.
 */

`timescale 100ns / 10ns
`include "rysy_pkg.vh"
`include "cmp.vh"

module cmp(
  input wire [`REG_LEN-1:0] rs1_d,
  input wire [`REG_LEN-1:0] rs2_d,
  input wire [2:0] cmp_op,
  output wire b // can be 1 or 0.
);


  reg signed [`REG_LEN-1:0] rs1_d_s;
  reg signed [`REG_LEN-1:0] rs2_d_s;
  reg signed o; // if we want connect "output wire" from module to the result from
  // our instructions, it's necessary. 

  assign b = o; // it's necessary, because we want assign two "input wire" to the one var.

  always@(*)
    begin

      rs1_d_s = rs1_d; // This two lines must be inside always block
      rs2_d_s = rs2_d;

      case(cmp_op)
        `EQ : o = (rs1_d == rs2_d); 	
        `NE : o = (rs1_d != rs2_d); 	
        `LT : o = (rs1_d_s < rs2_d_s); 	
        `GE : o = (rs1_d_s >= rs2_d_s); 
        `LTU : o = (rs1_d < rs2_d); 	
        `GEU : o = (rs1_d >= rs2_d); 	
        default: o = 0;
      endcase
    end

endmodule
