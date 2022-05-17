/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 * 
 * Mozerpol added comments
 * It is a simple ALU for comparing operations
 This ALU can take two operators:
 1. rs1_d from reg_file module. 
 2. rs2_d from reg_file module.
 So we can just say that this ALU compares two simple numbers.
 We have also third input, uses to select the type of operation.
 */

`include "rysy_pkg.sv"
`default_nettype none

import rysyPkg::*;

package cmpPkg;
typedef enum bit [2:0] {
  EQ, 	// 000
  NE, 	// 001
  LT, 	// 010
  GE, 	// 011 
  LTU, 	// 100
  GEU	// 101
} cmp_op;
endpackage : cmpPkg

module cmp(
  input wire [REG_LEN-1:0]rs1_d,
  input wire [REG_LEN-1:0]rs2_d,
  input cmpPkg::cmp_op cmp_op,
  output logic b // can be 1 or 0.
);

  logic signed [REG_LEN-1:0]rs1_d_s;
  logic signed [REG_LEN-1:0]rs2_d_s;

  assign rs1_d_s = rs1_d;
  assign rs2_d_s = rs2_d;

  always_comb
    case(cmp_op)
      cmpPkg::EQ: b = (rs1_d == rs2_d); 	
      cmpPkg::NE: b = (rs1_d != rs2_d); 	
      cmpPkg::LT: b = (rs1_d_s < rs2_d_s); 	
      cmpPkg::GE: b = (rs1_d_s >= rs2_d_s); 
      cmpPkg::LTU: b = (rs1_d < rs2_d); 	
      cmpPkg::GEU: b = (rs1_d >= rs2_d); 	
      default: b = 1'b0;
    endcase
endmodule

`default_nettype wire
