/*
 * Mozerpol 2021
 
 Our multiplexer can take two values:
 1. Value IMM from decode part. For example in addi instruction we're adding number to the register. 
 This action is performed by ALU, ALU has two operands, first comes from alu1_sel multiplexer, second
 from alu2_sel multiplexer. IF first mux will give rs1_d number, then second mux can pass to ALU IMM
 value, and after this ALU can add rs1_d and IMM. So IMM value is not value from any register (x0-x31),
 but this value comes instruction argument.
 
 2. Operand rs2_d which comes from reg_file. This operand can be simple number for ALU like 12 or 3.   
 */

`timescale 100ns / 10ns

`include "alu2_mux.vh"
`include "rysy_pkg.vh"

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

