// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock

`timescale 100ns / 10ns

module simple_dual_port_ram_single_clock
  #(parameter ADDR_WIDTH=8,
    parameter CODE = "regop.mem"
   ) (
    input [(ADDR_WIDTH-1):0] raddr,
    input clk,
    output reg [31:0] q
  );

  // Declare the RAM variable
  reg [31:0] ram[99:0];

  initial
    begin
      $readmemh(CODE, ram); /* $readmem[hb]("File", ArrayName, StartAddr, EndAddr), it's for reading hex
      values from test files. Read from CODE and save in ram. */
    end

  always@(posedge clk)
    // Read (if read_addr == write_addr, return OLD data).	To return
    // NEW data, use = (blocking write) rather than <= (non-blocking write)
    // in the write assignment.	 NOTE: NEW data may require extra bypass
    // logic around the RAM.
    q <= ram[raddr]; // q <= ram[raddr];

endmodule
