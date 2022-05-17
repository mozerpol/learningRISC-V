/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

import rysyPkg::*;

module reg_file
#(parameter ADDR_LEN = 5) (
	input wire [ADDR_LEN-1:0]rs1,
	input wire [ADDR_LEN-1:0]rs2,
	input wire [ADDR_LEN-1:0]rd,
	input wire [REG_LEN-1:0]rd_d,
	input wire reg_wr,
	input wire clk,
	output logic [REG_LEN-1:0]rs1_d,
	output logic [REG_LEN-1:0]rs2_d
);

	logic [REG_LEN-1:0]x[REG_NUM-1:0];

	assign rs1_d = (rs1 == 0) ? '0 : x[rs1];
	assign rs2_d = (rs2 == 0) ? '0 : x[rs2];

	always_ff @(posedge clk)
		if (reg_wr)
			x[rd] <= rd_d;

endmodule

`default_nettype wire
