/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 * Mozerpol added comments
 */

`include "rysy_pkg.sv"

`default_nettype none


import rysyPkg::*;

package aluPkg;
	typedef enum bit [3:0] {
		ADD, // ADD = 0000
		SUB, // SUB = 0001
		XOR, // XOR = 0010
		OR,
		AND,
		SLL,
		SRL,
		SRA,
		SLT,
		SLTU // SLTU = 1001
      	// We can put here maximum 16 instructions, because our bus has width
     	 // 2^4 = 16.  We have 
	} alu_op;
endpackage : aluPkg

module alu(
	input wire [REG_LEN-1:0]alu_in1,
	input wire [REG_LEN-1:0]alu_in2,
	input aluPkg::alu_op alu_op,
	output wire [REG_LEN-1:0]alu_out
);
  	// Auxiliary variables for output purposes, we can't connect "output wire [REG_LEN-1:0]alu_out"
  	// directly to the equation "alu_in1 + alu_in2;", if we do it we'll get:
  	// "alu_out is not a valid left-hand side of a procedural assignment."
 	logic signed [REG_LEN-1:0] o;
  	assign alu_out = o;

  	// Auxiliary variables for input purposes, we can't connect
  	// "aluPkg::SRA: o = alu_in1_s >>> alu_in2[4:0];". There will be no error 
  	// but an incorrect result of the operation.
	logic signed [REG_LEN-1:0]alu_in1_s;
	logic signed [REG_LEN-1:0]alu_in2_s;
	assign alu_in1_s = alu_in1;
	assign alu_in2_s = alu_in2;

	always_comb begin
		case (alu_op)
			aluPkg::ADD: o = alu_in1 + alu_in2;
			aluPkg::SUB: o = alu_in1 - alu_in2;
			aluPkg::XOR: o = alu_in1 ^ alu_in2;
			aluPkg::OR: o = alu_in1 | alu_in2;
			aluPkg::AND: o = alu_in1 & alu_in2;
			aluPkg::SLL: o = alu_in1 << alu_in2[4:0];
			aluPkg::SRL: o = alu_in1 >> alu_in2[4:0];
			aluPkg::SRA: o = alu_in1_s >>> alu_in2[4:0];
			aluPkg::SLT: o = alu_in1_s < alu_in2_s;
			aluPkg::SLTU: o = alu_in1 < alu_in2;
			default: o = '0;
		endcase
	end

endmodule

`default_nettype wire
