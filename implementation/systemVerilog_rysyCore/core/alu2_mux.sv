/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

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
