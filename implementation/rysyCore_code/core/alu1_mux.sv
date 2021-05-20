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

`include "rysy_pkg.sv"
`default_nettype none

import rysyPkg::*;

package alu1Pkg;
typedef enum bit {
  ALU1_RS,
  ALU1_PC
} alu1_sel;
endpackage : alu1Pkg

module alu1_mux (
  input wire [REG_LEN-1:0] rs1_d,
  input wire [REG_LEN-1:0] pc,
  input alu1Pkg::alu1_sel alu1_sel,
  input wire clk,
  output logic [REG_LEN-1:0] alu_in1
);

  logic [REG_LEN-1:0]old_pc[1:0];

  always_ff @(posedge clk) begin
    old_pc[1] <= pc;
    old_pc[0] <= old_pc[1];
  end

  always_comb
    case (alu1_sel)
      alu1Pkg::ALU1_RS: alu_in1 = rs1_d;
      alu1Pkg::ALU1_PC: alu_in1 = old_pc[0];
    endcase

endmodule

`default_nettype wire
