/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

module gpio (
	input wire [7:0]addr,
	input wire [3:0]be,
	input wire [31:0]wdata,
	input wire we,
	input wire clk,
	input wire rst,
	output wire [31:0]q,
	output wire [3:0]gpio
);

	logic [31:0]gpio_state;

	always_ff @(posedge clk) begin
		if (rst)
			gpio_state <= '0;
		else if(we && addr == '0)
			gpio_state <= wdata;
	end

	assign gpio = ~gpio_state[3:0];
	assign q = gpio_state;
endmodule

`default_nettype wire
