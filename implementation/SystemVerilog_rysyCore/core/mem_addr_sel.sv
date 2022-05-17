/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

import rysyPkg::*;

package pcPkg;
	typedef enum bit [1:0] {
		PC_ALU,
		PC_P4,
		PC_M4,
		PC_OLD
	} pc_sel;

	typedef enum bit {
		MEM_PC,
		MEM_ALU
	} mem_sel;
endpackage : pcPkg

module mem_addr_sel (
	input wire clk,
	input wire rst,
	input pcPkg::pc_sel pc_sel,
	input pcPkg::mem_sel mem_sel,
	input wire [REG_LEN-1:0]alu_out,
	output logic [REG_LEN-1:0]addr,
	output logic [REG_LEN-1:0]pc
);
	logic [REG_LEN-1:0]pc_reg;

	always_ff @(posedge clk) begin
		case(pc_sel)
			pcPkg::PC_ALU: pc_reg <= alu_out;
			pcPkg::PC_P4: pc_reg <= pc_reg + 4;
			pcPkg::PC_OLD: pc_reg <= pc_reg;
			pcPkg::PC_M4: pc_reg <= pc_reg - 4;
			default: pc_reg <= pc_reg;
		endcase
		if (rst)
			pc_reg <= '0;
	end

	assign pc = pc_reg;

	always_comb
		case(mem_sel)
			pcPkg::MEM_PC: addr = pc_reg;
			pcPkg::MEM_ALU: addr = alu_out;
		endcase
endmodule

`default_nettype wire
