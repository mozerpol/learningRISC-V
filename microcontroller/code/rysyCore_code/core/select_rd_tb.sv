/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none
`timescale 100ns / 10ns

import rysyPkg::*;

module select_rd_tb;

	logic [REG_LEN-1:0]in;
	selectPkg::sel_type sel_type;
	logic [1:0]sel_addr;
	logic [REG_LEN-1:0]out;
	logic [3:0]be;

	select_rd dut(
		.rdata(in),
		.sel_type(sel_type),
		.sel_addr_old(sel_addr),
		.rd_mem(out)
	);

	localparam N = 15;
	logic [REG_LEN-1:0]in_a[N-1:0] = {32'h12345678, 32'h12345678,
	    32'h12345678, 32'h12345678, 32'h12345678, 32'h12345678,
	    32'h12345678, 32'h12345678, 32'h12345678, 32'h12345678,
	    32'h12345678, 32'h12345678, 32'h12345678, 32'h00ff0000,
	    32'h00ff0000};
	selectPkg::sel_type sel_type_a[N-1:0] = {selectPkg::SB,
	    selectPkg::SB, selectPkg::SB, selectPkg::SB, selectPkg::SH,
	    selectPkg::SH, selectPkg::SW, selectPkg::SBU, selectPkg::SBU,
	    selectPkg::SBU, selectPkg::SBU, selectPkg::SHU, selectPkg::SHU,
	    selectPkg::SB, selectPkg::SBU};
	logic [1:0]sel_addr_a[N-1:0] = {2'b00, 2'b01, 2'b10, 2'b11, 2'b00,
	    2'b10, 2'b00, 2'b00, 2'b01, 2'b10, 2'b11, 2'b00, 2'b10, 2'b10,
	    2'b10};
	logic [REG_LEN-1:0]out_a[N-1:0] = {32'h00000078, 32'h00000056,
	    32'h00000034, 32'h00000012, 32'h00005678, 32'h00001234,
	    32'h12345678, 32'h00000078, 32'h00000056, 32'h00000034,
    	    32'h00000012, 32'h00005678, 32'h00001234, 32'hffffffff,
 	    32'h000000ff};

	initial begin
		for (int i=0; i<N; i++) begin
			in = in_a[i];
			sel_type = sel_type_a[i];
			sel_addr = sel_addr_a[i];
			#5
			if ((out_a[i] != out))
				$display("In: %x, sel_type:%s addr %d, out: %x != %x",
				    in, sel_type.name(), sel_addr, out, out_a[i]);
		end
	end
endmodule

`default_nettype wire
