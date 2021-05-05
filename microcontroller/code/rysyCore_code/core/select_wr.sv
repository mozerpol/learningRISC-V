/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

import rysyPkg::*;

module select_wr(
	input wire [REG_LEN-1:0]rs2_d,
	input selectPkg::sel_type sel_type,
	input wire [1:0]sel_addr,
	output logic [3:0]be,
	output logic [REG_LEN-1:0]wdata
);

	always_comb
		case (sel_type)
			selectPkg::SB:
				case (sel_addr)
					2'b00: wdata = {24'b0, rs2_d[7:0]};
					2'b01: wdata = {16'b0, rs2_d[7:0], 8'b0};
					2'b10: wdata = {8'b0, rs2_d[7:0], 16'b0};
					2'b11: wdata = {rs2_d[7:0], 24'b0};
					default: wdata = {24'b0, rs2_d[7:0]};
				endcase
			selectPkg::SH:
				case (sel_addr)
					2'b00: wdata = {16'b0, rs2_d[15:0]};
					2'b10: wdata = {rs2_d[15:0], 16'b0};
					default: wdata = {16'b0, rs2_d[15:0]};
				endcase
			selectPkg::SW: wdata = rs2_d;
			default: wdata = rs2_d;
		endcase

	always_comb
		case(sel_type)
			selectPkg::SB: be = 4'b0001 << sel_addr;
			selectPkg::SH: be = 4'b0011 << sel_addr;
			selectPkg::SW: be = 4'b1111;
			default: be = 4'b1111;
		endcase
	endmodule

`default_nettype wire
