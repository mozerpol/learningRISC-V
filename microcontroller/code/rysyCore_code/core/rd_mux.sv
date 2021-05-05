/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

import rysyPkg::*;

package rdPkg;
	typedef enum bit[1:0] {
		RD_IMM,
		RD_PCP4,
		RD_ALU,
		RD_MEM
	} rd_sel;
endpackage : rdPkg

module rd_mux (
	input wire [REG_LEN-1:0]imm,
	input wire [REG_LEN-1:0]pc,
	input wire [REG_LEN-1:0]alu_out,
	input wire [REG_LEN-1:0]rd_mem,
	input wire clk,
	input rdPkg::rd_sel rd_sel,
	output logic [REG_LEN-1:0]rd_d
);

	logic [REG_LEN-1:0]old_pc;

	always_ff @(posedge clk)
		old_pc <= pc;

	always_comb
		case(rd_sel)
			rdPkg::RD_IMM: rd_d = imm;
			rdPkg::RD_PCP4: rd_d = old_pc;
			rdPkg::RD_ALU: rd_d = alu_out;
			rdPkg::RD_MEM: rd_d = rd_mem;
		endcase

endmodule

`default_nettype wire

