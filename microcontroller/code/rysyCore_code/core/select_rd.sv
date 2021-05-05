/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

import rysyPkg::*;

module select_rd(
	input wire [REG_LEN-1:0]rdata,
	input selectPkg::sel_type sel_type,
	input wire [1:0]sel_addr_old,
	output logic [REG_LEN-1:0]rd_mem
);

	always_comb
		case (sel_type)
			selectPkg::SB:
				case (sel_addr_old)
					2'b00: rd_mem = {rdata[7] ? 24'hffffff : 24'h0, rdata[7:0]};
					2'b01: rd_mem = {rdata[15] ? 24'hffffff : 24'h0, rdata[15:8]};
					2'b10: rd_mem = {rdata[23] ? 24'hffffff : 24'h0, rdata[23:16]};
					2'b11: rd_mem = {rdata[31] ? 24'hffffff : 24'h0, rdata[31:24]};
					default: rd_mem = 'b0;
				endcase
			selectPkg::SH:
				case (sel_addr_old)
					2'b00: rd_mem = {rdata[15] ? 16'hffff : 16'h0, rdata[15:0]};
					2'b10: rd_mem = {rdata[31] ? 16'hffff : 16'h0, rdata[31:16]};
					default: rd_mem = 'b0;
				endcase
			selectPkg::SW: rd_mem = rdata;
			selectPkg::SBU:
				case (sel_addr_old)
					2'b00: rd_mem = {24'h0, rdata[7:0]};
					2'b01: rd_mem = {24'h0, rdata[15:8]};
					2'b10: rd_mem = {24'h0, rdata[23:16]};
					2'b11: rd_mem = {24'h0, rdata[31:24]};
					default: rd_mem = 'b0;
				endcase
			selectPkg::SHU:
				case (sel_addr_old)
					2'b00: rd_mem = {16'h0, rdata[15:0]};
					2'b10: rd_mem = {16'h0, rdata[31:16]};
					default: rd_mem = 'b0;
				endcase
			default: rd_mem = 'b0;
		endcase
endmodule

`default_nettype wire
