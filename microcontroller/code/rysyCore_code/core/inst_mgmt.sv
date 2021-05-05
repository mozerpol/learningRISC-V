/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

import rysyPkg::*;

package instMgmtPkg;
	typedef enum bit[1:0] {
		INST_OLD,
		INST_NOP,
		INST_MEM
	} inst_sel;
endpackage : instMgmtPkg

module inst_mgmt (
	input wire clk,
	input wire rst,
	input wire [REG_LEN-1:0]rdata,
	input instMgmtPkg::inst_sel inst_sel,
	output logic [REG_LEN-1:0]inst
);

	always @(posedge clk) begin
		case (inst_sel)
			instMgmtPkg::INST_OLD: inst <= inst;
			instMgmtPkg::INST_NOP: inst <= NOP;
			instMgmtPkg::INST_MEM: inst <= rdata;
			default: inst <= NOP;
		endcase
		if (rst)
			inst <= NOP;
	end
endmodule

`default_nettype wire
