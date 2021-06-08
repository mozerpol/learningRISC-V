`timescale 100ns/10ns
`include "rysy_pkg.vh"

`define SB  3'b000
`define SH  3'b001
`define SW  3'b010
`define SBU 3'b011
`define SHU 3'b100

module select_rd_tb;

  reg [31:0]in;
  reg [2:0] sel_type;
  reg [1:0] sel_addr;
  wire [31:0] out;
  reg [3:0] be;

  select_rd dut(
    .rdata(in),
    .sel_type(sel_type),
    .sel_addr_old(sel_addr),
    .rd_mem(out)
  );

  localparam N = 15;
  reg [`REG_LEN-1:0] in_a[N-1:0];
  reg [2:0] sel_type_a[N-1:0];
  
  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;
    
    in_a[0] = 32'h12345678;
    in_a[1] = 32'h12345678;
    in_a[2] = 32'h12345678;
    in_a[3] = 32'h12345678;
    in_a[4] = 32'h12345678;
    in_a[5] = 32'h12345678;
    in_a[6] = 32'h12345678;
    in_a[7] = 32'h12345678;
    in_a[8] = 32'h12345678;
    in_a[9] = 32'h12345678;
    in_a[10] = 32'h12345678;
    in_a[11] = 32'h12345678;
    in_a[12] = 32'h12345678;
    in_a[13] = 32'h00ff0000;
    in_a[14] = 32'h00ff0000;
    
    sel_type_a[0] = `SB;
    sel_type_a[1] = `SB;
    sel_type_a[2] = `SB;
    sel_type_a[3] = `SB;
    sel_type_a[4] = `SH;
    sel_type_a[5] = `SH;
    sel_type_a[6] = `SW;
    sel_type_a[7] = `SBU;
    sel_type_a[8] = `SBU;
    sel_type_a[9] = `SBU;
    sel_type_a[10] = `SBU;
    sel_type_a[11] = `SHU;
    sel_type_a[12] = `SHU;
    sel_type_a[13] = `SB;
    sel_type_a[14] = `SBU;
  end

endmodule
