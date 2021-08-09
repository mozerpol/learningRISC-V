// Quartus Prime SystemVerilog Template
//
// Simple Dual-Port RAM with different read/write addresses and single read/write clock
// and with a control for writing single bytes into the memory word; byte enable

`timescale 100ns / 10ns

module byte_enabled_simple_dual_port_ram
  #(parameter
    CODE = "regop.mem",
    ADDR_WIDTH = 8,
    BYTE_WIDTH = 8,
    BYTES = 4,
    WIDTH = BYTES * BYTE_WIDTH
   )
  ( 
    input [ADDR_WIDTH-1:0] waddr,
    input [ADDR_WIDTH-1:0] raddr,
    input [BYTES-1:0] be,
    input  wire [WIDTH-1:0] wdata,
    input we, clk,
    output reg [WIDTH-1:0] q
  );


  localparam WORDS = 1 << ADDR_WIDTH;

  // use a multi-dimensional packed array to model individual bytes within the word
  // reg [BYTE_WIDTH-1:0] ram[BYTES-1:0][0:WORDS-1];
  reg [BYTE_WIDTH-1:0] ram[0:ADDR_WIDTH-1];

  initial
    begin
      $readmemh(CODE, ram);
    end

  always@(posedge clk)
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

endmodule
/*
poomocne pliki: reg_file, mux
linki:
https://www.chipverify.com/systemverilog/systemverilog-packed-arrays - moze jakos konkatenacja pomoze
*/
