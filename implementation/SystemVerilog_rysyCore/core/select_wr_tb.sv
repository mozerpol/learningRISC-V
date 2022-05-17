/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none
`timescale 100ns / 10ns

import rysyPkg::*;

module select_wr_tb;

	logic [REG_LEN-1:0]in;
	selectPkg::sel_type sel_type;
	logic [1:0]sel_addr;
	logic [REG_LEN-1:0]out;
	logic [3:0]be;

	select_wr dut(
		.rs2_d(in),
		.sel_type(sel_type),
		.sel_addr(sel_addr),
		.be(be),
		.wdata(out)
	);

	localparam N = 7;
	logic [REG_LEN-1:0]in_a[N-1:0] = {32'h12345678, 32'h12345678,
	    32'h12345678, 32'h12345678, 32'h12345678, 32'h12345678,
	    32'h12345678};
	selectPkg::sel_type sel_type_a[N-1:0] = {selectPkg::SB,
	    selectPkg::SB, selectPkg::SB, selectPkg::SB, selectPkg::SH,
	    selectPkg::SH, selectPkg::SW};
	logic [1:0]sel_addr_a[N-1:0] = {2'b00, 2'b01, 2'b10, 2'b11, 2'b00,
	    2'b10, 2'b00};
	logic [REG_LEN-1:0]out_a[N-1:0] = {32'h00000078, 32'h00007800,
	    32'h00780000, 32'h78000000, 32'h00005678, 32'h56780000,
	    32'h12345678};
	logic [3:0]be_a[N-1:0] = {4'b0001, 4'b0010, 4'b0100, 4'b1000,
	    4'b0011, 4'b1100, 4'b1111};

	initial begin
		for (int i=0; i<N; i++) begin
			in = in_a[i];
			sel_type = sel_type_a[i];
			sel_addr = sel_addr_a[i];
			#5
			if ((out_a[i] != out) || be_a[i] != be)
				$display("In: %x, sel_type:%s addr %d, out: %x != %x || be %d != %d",
				    in, sel_type.name(), sel_addr, out, out_a[i], be, be_a[i]);
		end
	end
endmodule

`default_nettype wire
