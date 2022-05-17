/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none
`timescale 100ns / 10ns

module reg_file_tb;

logic clk;
logic [4:0]rs1_addr;
logic [4:0]rs2_addr;
logic [4:0]rd_addr;
logic [31:0]rd_data;
logic wr;
logic [31:0]rs1_data;
logic [31:0]rs2_data;

reg_file dut (
	.rs1(rs1_addr),
	.rs2(rs2_addr),
	.rd(rd_addr),
	.rd_d(rd_data),
	.reg_wr(wr),
	.clk(clk),
	.rs1_d(rs1_data),
	.rs2_d(rs2_data)
);

initial begin
	clk <= 1'b1;
	forever
		#5 clk <= ~clk;
end

initial begin
	rs1_addr <= 0;
	rs2_addr <= 0;
	rd_addr <= 0;
	rd_data <= 0;
	wr <= 0;
	#30;
	rd_data <= 32'h00000001;
	rd_addr <= 5'h01;
	wr <= 1;
	#5;
	wr <= 0;
	rd_data <= 32'h00000002;
	rd_addr <= 5'h03;
	#5;
	wr <= 1;
	#5;
	wr <= 0;
	rs1_addr <= 5'h01;
	#10;
	rs2_addr <= 5'h03;
	#10
	rd_addr <= 5'h0;
	wr <= 1;
	rs1_addr <= 5'h0;
end

endmodule

`default_nettype wire
