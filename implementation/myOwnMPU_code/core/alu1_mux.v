/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 * Mozerpol added comments

 Our multiplexer can take two values:
 1. From the PC registry to pass a value to the ALU, which next calculate new address, for example to perform jump.
    But before passing value from PC to ALU we must wait two clock cycles to empty the pipeline. Two lines of code do this:
     old_pc[1] <= pc;
   	 old_pc[0] <= old_pc[1];
 2. Operand rs1_d which comes from reg_file. This operand can be simple number for ALU like 12 or 3.   
 */

`include "rysy_pkg.vh"
`timescale 100ns / 10ns

`define ALU1_RS 1'b0
`define ALU1_PC 1'b1

module alu1_mux (
  input wire [`REG_LEN-1:0] rs1_d,
  input wire [`REG_LEN-1:0] pc,
  input wire alu1_sel,
  input wire clk,
  output wire [`REG_LEN-1:0] alu_in1
);

  reg [`REG_LEN-1:0] o;
  reg [`REG_LEN-1:0] old_pc [1:0];

  assign alu_in1 = o;
  
  always@(posedge clk) 
    begin
      old_pc[1] <= pc;
      old_pc[0] <= old_pc[1];
    end

  always@(posedge clk, rs1_d, old_pc[0])
    case (alu1_sel)
      `ALU1_RS : o = rs1_d;
      `ALU1_PC : o = old_pc[0];
    endcase

endmodule
