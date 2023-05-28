/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

import rysyPkg::*;

package cmpPkg;
	typedef enum bit [2:0] {
		EQ,
		NE,
		LT,
		GE,
		LTU,
		GEU
	} cmp_op;
endpackage : cmpPkg

module cmp(
	input wire [REG_LEN-1:0]rs1_d,
	input wire [REG_LEN-1:0]rs2_d,
	input cmpPkg::cmp_op cmp_op,
	output logic b
);

logic signed [REG_LEN-1:0]rs1_d_s;
logic signed [REG_LEN-1:0]rs2_d_s;

assign rs1_d_s = rs1_d;
assign rs2_d_s = rs2_d;

always_comb
	case(cmp_op)
		cmpPkg::EQ: b = (rs1_d == rs2_d);
		cmpPkg::NE: b = (rs1_d != rs2_d);
		cmpPkg::LT: b = (rs1_d_s < rs2_d_s);
		cmpPkg::GE: b = (rs1_d_s >= rs2_d_s);
		cmpPkg::LTU: b = (rs1_d < rs2_d);
		cmpPkg::GEU: b = (rs1_d >= rs2_d);
		default: b = 1'b0;
	endcase
endmodule

`default_nettype wire
