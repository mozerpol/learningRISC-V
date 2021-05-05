/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none
`timescale 100ns / 10ns
module decode_tb;

	logic [31:0]i;

	decode dut (
		.inst(i)
	);

	initial begin
		i <= 32'h00000000;		
		#5 i <= 32'h000230B7; // lui x1 0x23
		#5 i <= 32'h05408113; // addi x2 x1 0x54
		#5 i <= 32'h001101B3; // add x3 x2 x1
		#5 i <= 32'h40110233; // sub x4 x2 x1
	end

endmodule

`default_nettype wire
