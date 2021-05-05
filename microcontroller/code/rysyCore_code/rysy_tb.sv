/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none
`timescale 100ns / 10ns

module rysy_tb #(parameter CODE="code_regop.mem");

	logic clk;
	logic rst;
	logic [3:0]gpio;

	initial begin
		clk = 1'b1;
		forever
			# 5 clk = ~clk;
	end

	initial begin
		rst <= 1'b0;
		#25 rst <= 1'b1;
	end

	rysy #(
		.CODE(CODE)
	) dut(
		.clk(clk),
		.rst(rst),
		.gpio(gpio)
	);

endmodule

`default_nettype wire
