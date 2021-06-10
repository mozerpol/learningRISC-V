`default_nettype none
`timescale 100ns/10ns

module select_wr_tb;
  reg [`REG_LEN-1:0] in;
  reg [2:0] sel_type;
  reg [1:0] sel_addr;
  wire [`REG_LEN-1:0] out;
  wire [3:0] be;

  select_wr dut(
    .rs2_d(in),
    .sel_type(sel_type),
    .sel_addr(sel_addr),
    .be(be),
    .wdata(out)
  );

  localparam N = 7;
  reg [`REG_LEN-1:0] in_a[N-1:0];
  reg [2:0] sel_type_a[N-1:0];
  reg [1:0] sel_addr_a[N-1:0];
  reg [`REG_LEN-1:0] out_a[N-1:0];
  reg [3:0] be_a[N-1:0];
  integer i;

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    
    in_a[0] = 32'h12345678;
    in_a[1] = 32'h12345678;
    in_a[2] = 32'h12345678;
    in_a[3] = 32'h12345678;
    in_a[4] = 32'h12345678;
    in_a[5] = 32'h12345678;
    in_a[6] = 32'h12345678;

    sel_type_a[0] = `SW;
    sel_type_a[1] = `SH;
    sel_type_a[2] = `SH;
    sel_type_a[3] = `SB;
    sel_type_a[4] = `SB;
    sel_type_a[5] = `SB;
    sel_type_a[6] = `SB;

    sel_addr_a[0] = 2'b00;
    sel_addr_a[1] = 2'b10;
    sel_addr_a[2] = 2'b00;
    sel_addr_a[3] = 2'b11;
    sel_addr_a[4] = 2'b10;
    sel_addr_a[5] = 2'b01;
    sel_addr_a[6] = 2'b00;
    
    out_a[0] = 32'h12345678;
    out_a[1] = 32'h56780000;
    out_a[2] = 32'h00005678;
    out_a[3] = 32'h78000000;
    out_a[4] = 32'h00780000;
    out_a[5] = 32'h00007800;
    out_a[6] = 32'h00000078;

    be_a[0] = 4'b1111;
    be_a[1] = 4'b1100;
    be_a[2] = 4'b0011;
    be_a[3] = 4'b1000;
    be_a[4] = 4'b0100;
    be_a[5] = 4'b0010;
    be_a[6] = 4'b0001;

    for(i = 0; i < N; i=i+1) 
      begin
        in = in_a[i];
        sel_type = sel_type_a[i];
        sel_addr = sel_addr_a[i];
        #5;
        if ((out_a[i] != out) || be_a[i] != be)
          $display("In: %x | sel_type: %s | addr %d | out: %x != %x || be %d != %d",
                   in, sel_type, sel_addr, out, out_a[i], be, be_a[i]);
      end

  end

endmodule
