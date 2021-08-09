`timescale 100ns / 10ns

`define WIDTH 32

module byte_enabled_simple_dual_port_ram_tb;

  reg clk_tb;
  reg we_tb;
  reg [31:0] wdata_tb;
  reg [3:0] be_tb;
  reg [7:0] waddr_tb;
  reg [7:0] raddr_tb;
  wire [31:0] q_tb;

  byte_enabled_simple_dual_port_ram uut(
    .clk(clk_tb),
    .we(we_tb),
    .wdata(wdata_tb),
    .be(be_tb),
    .waddr(waddr_tb),
    .raddr(raddr_tb),
    .q(q_tb)
  );

  integer i;

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;

    #5
    we_tb = 0;
    #5
    we_tb = 1;

    for(i = 0; i < 9; i=i+1)
      begin
        raddr_tb = i;
        #10;
      end 

    #10 $finish;
  end

  initial begin
    clk_tb <= 1'b1;
    forever
      #5 clk_tb <= ~clk_tb;
  end

endmodule
