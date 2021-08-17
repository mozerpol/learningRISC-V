/*-
   * SPDX-License-Identifier: BSD-3-Clause
   *
   * Copyright (c) 2019 Rafal Kozik
   * All rights reserved.
   */

// Quartus Prime SystemVerilog Template
//
// Simple Dual-Port RAM with different read/write addresses and single read/write clock
// and with a control for writing single bytes into the memory word; byte enable

module byte_enabled_simple_dual_port_ram
  #(parameter
    CODE = "regop.mem",
    int ADDR_WIDTH = 8, // because one machine word has 8 bytes
    int BYTE_WIDTH = 8, // because it's in hex. 1 sign in hex = 1 byte
    int BYTES = 4,
    int WIDTH = BYTES * BYTE_WIDTH // 32 bits
   )
  ( 
    input [ADDR_WIDTH-1:0] waddr, // 8 width one vector: [7, 6, 5, 4, 3, 2, 1, 0]
    input [ADDR_WIDTH-1:0] raddr,
    input [BYTES-1:0] be,
    input [BYTES-1:0][BYTE_WIDTH-1:0] wdata, // 4x8 vector:
    /*
          [7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0]
      */
    input we, clk,
    output reg [WIDTH-1:0] q
  );
  localparam int WORDS = 1 << ADDR_WIDTH; // 8'd100, memory length, 100 rows

  // use a multi-dimensional packed array to model individual bytes within the word
  logic [BYTES-1:0][BYTE_WIDTH-1:0] ram[0:WORDS-1]; // eight 4x8 vectors:
  /*
    0:
		[7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0]
	1:
    	[7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0]
	.
    .
    .

    99:
    	[7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0] [7, 6, 5, 4, 3, 2, 1, 0]

	*/

  initial
    begin
      $readmemh(CODE, ram); /* $readmem[hb]("File", ArrayName, StartAddr, EndAddr), it's for reading hex
      values from test files. Read from CODE and save in ram. */
    end

  always_ff@(posedge clk)
    begin
      if(we) begin
        // edit this code if using other than four bytes per word
        if(be[0]) ram[waddr][0] <= wdata[0];
        if(be[1]) ram[waddr][1] <= wdata[1];
        if(be[2]) ram[waddr][2] <= wdata[2];
        if(be[3]) ram[waddr][3] <= wdata[3];
      end
      q <= ram[raddr];
    end
endmodule : byte_enabled_simple_dual_port_ram

// Nice link about arrays: http://www.pepedocs.com/notes?tid=fpga&nid=fpga
