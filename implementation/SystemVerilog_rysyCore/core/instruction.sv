/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

package instPkg;

import opcodePkg::opcode;

typedef struct packed {
	logic [6:0]func7;
	logic [4:0]rs2;
	logic [4:0]rs1;
	logic [2:0]func3;
	logic [4:0]rd;
	opcode op;
	logic [1:0]low_op;
} R_type;

typedef struct packed {
	logic [11:0]imm;
	logic [4:0]rs1;
	logic [2:0]func3;
	logic [4:0]rd;
	opcode op;
	logic [1:0]low_op;
} I_type;

typedef struct packed {
	logic [6:0]imm_11_5;
	logic [4:0]rs2;
	logic [4:0]rs1;
	logic [2:0]func3;
	logic [4:0]imm_4_0;
	opcode op;
	logic [1:0]low_op;
} S_type;

typedef struct packed {
	logic imm_12;
	logic [5:0]imm_10_5;
	logic [4:0]rs2;
	logic [4:0]rs1;
	logic [2:0]func3;
	logic [3:0]imm_4_1;
	logic imm_11;
	opcode op;
	logic [1:0] low_op;
} B_type;

typedef struct packed {
	logic [19:0]imm;
	logic [4:0]rd;
	opcode op;
	logic [1:0]low_op;
} U_type;

typedef struct packed {
	logic imm_20;
	logic [9:0]imm_10_1;
	logic imm_11;
	logic [7:0]imm_19_12;
	logic [4:0]rd;
	opcode op;
	logic [1:0] low_op;
} J_type;

endpackage : instPkg
