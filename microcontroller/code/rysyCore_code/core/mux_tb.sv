/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none
`timescale 100ns / 10ns

module mux_tb;

	logic [7:0]data_in[3:0];
	logic [1:0]in;
	logic [7:0]out;

	mux #(
		.DATA_WIDTH(8),
		.INPUTS(4)
	) dut (
		.inputs(data_in),
		.addr(in),
		.out(out)
	);

	initial begin
		data_in = {8'd3, 8'd2, 8'd1, 8'd0};
		in = 2'd0;
		#5 in = 2'd1;
		#5 in = 2'd2;
		#5 in = 2'd3;
		#5 in = 2'd0;
		#5 in = 2'd1;
	end
endmodule

`default_nettype wire
