/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

module bus_interconnect #(parameter
	WIDTH = 32
) (
	input wire clk,
	input wire [WIDTH-1:0]addr,
	input wire [WIDTH-1:0]rdata_gpio,
	input wire [WIDTH-1:0]rdata_ram,
	input wire we,
	output logic [WIDTH-1:0]rdata,
	output logic we_ram,
	output logic we_gpio
);
	logic [3:0]next_select;

	always_ff @(posedge clk)
		next_select <= addr[31:28];

	always_comb
		case(next_select)
			4'd2: rdata = rdata_gpio;
			default: rdata = rdata_ram;
		endcase

	assign we_ram = we & (addr[31:28] != 4'd2);
	assign we_gpio = we & (addr[31:28] == 4'd2);

endmodule

`default_nettype wire
