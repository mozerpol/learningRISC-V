/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

module decode (
	input wire [31:0]inst,
	output wire [4:0]rd,
	output wire [4:0]rs1,
	output wire [4:0]rs2,
	output wire [31:0]imm_I,
	output wire [31:0]imm_S,
	output wire [31:0]imm_B,
	output wire [31:0]imm_U,
	output wire [31:0]imm_J,
	output opcodePkg::opcode opcode,
	output wire [2:0]func3,
	output wire [6:0]func7
);

	instPkg::R_type r;
	instPkg::I_type i;
	instPkg::S_type s;
	instPkg::B_type b;
	instPkg::U_type u;
	instPkg::J_type j;

	logic sign;

	assign r = inst;
	assign i = inst;
	assign s = inst;
	assign b = inst;
	assign u = inst;
	assign j = inst;


	assign opcode = r.op;
	assign func3 = r.func3;
	assign func7 = r.func7;
	assign rd = r.rd;
	assign rs1 = r.rs1;
	assign rs2 = r.rs2;

	assign sign = inst[31];

	assign imm_I[10:0] = i.imm[10:0];
	assign imm_I[31:11] = (sign) ? 21'h1fffff : 21'h0;

	assign imm_S[10:0] = {s.imm_11_5[5:0], s.imm_4_0};
	assign imm_S[31:11] = (sign) ? 21'h1fffff : 21'h0;

	assign imm_B[11:0] = {b.imm_11, b.imm_10_5, b.imm_4_1, 1'b0};
	assign imm_B[31:12] = (sign) ? 20'hfffff : 20'h0;

	assign imm_U = {u.imm, 12'h0};

	assign imm_J[20:0] = {j.imm_20, j.imm_19_12, j.imm_11, j.imm_10_1, 1'b0};
	assign imm_J[31:21] = (sign) ? 11'h7ff : 11'h0;
endmodule

`default_nettype wire
