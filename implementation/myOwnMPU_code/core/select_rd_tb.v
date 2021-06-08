`timescale 100ns/10ns
`include "rysy_pkg.vh"

`define SB  3'b000
`define SH  3'b001
`define SW  3'b010
`define SBU 3'b011
`define SHU 3'b100

module select_rd_tb;

  reg [`REG_LEN-1:0]in;
  reg [2:0] sel_type;
  reg [1:0] sel_addr;
  wire [`REG_LEN-1:0] out;
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
  reg [1:0] sel_addr_a[N-1:0];
  reg [`REG_LEN-1:0] out_a[N-1:0];
  integer i;

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    in_a[0] = 32'h00ff0000;
    in_a[1] = 32'h00ff0000;
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
    in_a[13] = 32'h12345678;
    in_a[14] = 32'h12345678;

    sel_type_a[0] = `SBU;
    sel_type_a[1] = `SB;
    sel_type_a[2] = `SHU;
    sel_type_a[3] = `SHU;
    sel_type_a[4] = `SBU;
    sel_type_a[5] = `SBU;
    sel_type_a[6] = `SBU;
    sel_type_a[7] = `SBU;
    sel_type_a[8] = `SW;
    sel_type_a[9] = `SH;
    sel_type_a[10] = `SH;
    sel_type_a[11] = `SB;
    sel_type_a[12] = `SB;
    sel_type_a[13] = `SB;
    sel_type_a[14] = `SB;

    sel_addr_a[0] = 2'b10;
    sel_addr_a[1] = 2'b10;
    sel_addr_a[2] = 2'b10;
    sel_addr_a[3] = 2'b00;
    sel_addr_a[4] = 2'b11;
    sel_addr_a[5] = 2'b10;
    sel_addr_a[6] = 2'b01;
    sel_addr_a[7] = 2'b00;
    sel_addr_a[8] = 2'b00;
    sel_addr_a[9] = 2'b10;
    sel_addr_a[10] = 2'b00;
    sel_addr_a[11] = 2'b11;
    sel_addr_a[12] = 2'b10;
    sel_addr_a[13] = 2'b01;
    sel_addr_a[14] = 2'b00;

    out_a[0] = 32'h000000ff;
    out_a[1] = 32'hffffffff;
    out_a[2] = 32'h00001234;
    out_a[3] = 32'h00005678;
    out_a[4] = 32'h00000012;
    out_a[5] = 32'h00000034;
    out_a[6] = 32'h00000056;
    out_a[7] = 32'h00000078;
    out_a[8] = 32'h12345678;
    out_a[9] = 32'h00001234;
    out_a[10] = 32'h00005678;
    out_a[11] = 32'h00000012;
    out_a[12] = 32'h00000034;
    out_a[13] = 32'h00000056;
    out_a[14] = 32'h00000078;

    for (i = 0; i < N; i=i+1)
      begin
        in = in_a[i];
        sel_type = sel_type_a[i];
        sel_addr = sel_addr_a[i];
        #5;
        //         if ((out_a[i] != out))
        //           $display("In: %x, sel_type:%s addr %d, out: %x != %x", in, sel_type.name(), sel_addr, out, out_a[i]);
      end
  end
endmodule
