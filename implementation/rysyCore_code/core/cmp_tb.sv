/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none
`timescale 100ns / 10ns

module cmp_tb;
	logic [31:0]in1;
	logic [31:0]in2;
	cmpPkg::cmp_op cmp_op;
	logic b;

	cmp dut (
		.rs1_d(in1),
		.rs2_d(in2),
		.cmp_op(cmp_op),
		.b(b)
	);

	localparam N = 8;
	int i;
	logic [31:0]in1_a[N-1:0] = {32'd10,  32'd3, -32'd4,  32'd4, -32'd16, 32'd0, 32'd24, -32'd5};
	logic [31:0]in2_a[N-1:0] = {32'd2,  32'd10,  32'd4, -32'd4,   32'd2, 32'd0, 32'd24, -32'd5};
	logic [0:5]out[N-1:0] = {
		6'b010101,
		6'b011010,
		6'b011001,
		6'b010110,
		6'b011001,
		6'b100101,
		6'b100101,
		6'b100101
	};

	initial begin
		for (i=0; i<N; i++) begin
			in1 = in1_a[i];
			in2 = in2_a[i];
			cmp_op = cmp_op.first;
			do begin
				#1
				if  (out[i][cmp_op] != b)
					$display("i: %d, op:%s", i, cmp_op.name());
				#4 cmp_op = cmp_op.next;
			end while (cmp_op != cmp_op.first);
		end
	end
endmodule

`default_nettype wire
