/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

module rysy #(parameter
	CODE="code/blink_slow.mem"
) (
	input wire clk,
	input wire rst,
	output logic [3:0]gpio
);

	localparam WIDTH = 32;

	logic [WIDTH-1:0]addr;
	logic [WIDTH-1:0]rdata;
	logic [WIDTH-1:0]rdata_ram;
	logic [WIDTH-1:0]rdata_gpio;
	logic [WIDTH-1:0]wdata;
	logic [3:0]be;
	logic we;
	logic we_ram;
	logic we_gpio;

	rysy_core core(
		.clk(clk),
		.rst(~rst),
		.rdata(rdata),
		.wdata(wdata),
		.addr(addr),
		.we(we),
		.be(be)
	);

	bus_interconnect #(
		.WIDTH(WIDTH)
	) i (.*);

	byte_enabled_simple_dual_port_ram #(
		.CODE(CODE)
	) ram(
		.waddr(addr[9:2]),
		.raddr(addr[9:2]),
		.be(be),
		.wdata(wdata),
		.we(we_ram),
		.clk(clk),
		.q(rdata_ram)
	);

	gpio gpio1(
		.addr(addr[9:2]),
		.be(be),
		.wdata(wdata),
		.we(we_gpio),
		.clk(clk),
		.rst(~rst),
		.q(rdata_gpio),
		.gpio(gpio)
	);

endmodule

`default_nettype wire
