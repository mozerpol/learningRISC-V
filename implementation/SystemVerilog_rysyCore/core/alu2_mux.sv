/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 * Mozerpol added comments

 Our multiplexer can take two values:
 1. Value IMM from decode part. For example in addi instruction we're adding number to the register. 
 This action is performed by ALU, ALU has two operands, first comes from alu1_sel multiplexer, second
 from alu2_sel multiplexer. IF first mux will give rs1_d number, then second mux can pass to ALU IMM
 value, and after this ALU can add rs1_d and IMM. So IMM value is not value from any register (x0-x31),
 but this value comes instruction argument.
 
 2. Operand rs2_d which comes from reg_file. This operand can be simple number for ALU like 12 or 3.   
 */

`include "rysy_pkg.sv"
`default_nettype none

import rysyPkg::*;

package alu2Pkg;
	typedef enum bit {
		ALU2_RS,
		ALU2_IMM
	} alu2_sel;
endpackage : alu2Pkg

module alu2_mux (
	input wire [REG_LEN-1:0] rs2_d,
	input wire [REG_LEN-1:0] imm,
	input alu2Pkg::alu2_sel alu2_sel,
	output logic [REG_LEN-1:0] alu_in2
);

	always_comb
		case (alu2_sel)
			alu2Pkg::ALU2_RS: alu_in2 = rs2_d;
			alu2Pkg::ALU2_IMM: alu_in2 = imm;
		endcase
endmodule

`default_nettype wire
