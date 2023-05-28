/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

import rysyPkg::*;

package aluPkg;
	typedef enum bit [3:0] {
		ADD,
		SUB,
		XOR,
		OR,
		AND,
		SLL,
		SRL,
		SRA,
		SLT,
		SLTU
	} alu_op;
endpackage : aluPkg

module alu(
	input wire [REG_LEN-1:0]alu_in1,
	input wire [REG_LEN-1:0]alu_in2,
	input aluPkg::alu_op alu_op,
	output wire [REG_LEN-1:0]alu_out
);
	logic signed [REG_LEN-1:0] o;
	assign alu_out = o;

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
