/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

import rysyPkg::*;

package immPkg;
	typedef enum bit [2:0] {
		IMM_J,
		IMM_U,
		IMM_B,
		IMM_S,
		IMM_I,
		IMM_DEFAULT
	} imm_type;
endpackage : immPkg

module imm_mux (
	input wire [REG_LEN-1:0]imm_J,
	input wire [REG_LEN-1:0]imm_U,
	input wire [REG_LEN-1:0]imm_B,
	input wire [REG_LEN-1:0]imm_S,
	input wire [REG_LEN-1:0]imm_I,
	input immPkg::imm_type imm_type,
	output logic [REG_LEN-1:0]imm
);

	always_comb
		case(imm_type)
			immPkg::IMM_J: imm = imm_J;
			immPkg::IMM_U: imm = imm_U;
			immPkg::IMM_B: imm = imm_B;
			immPkg::IMM_S: imm = imm_S;
			immPkg::IMM_I: imm = imm_I;
			default: imm = '0;
		endcase

endmodule

`default_nettype wire
