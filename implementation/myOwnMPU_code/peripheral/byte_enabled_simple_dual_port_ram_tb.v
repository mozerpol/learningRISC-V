`timescale 100ns / 10ns

`define WIDTH 32

module byte_enabled_simple_dual_port_ram_tb;

  reg clk_tb;
  reg we_tb;
  reg [3:0][7:0] wdata_tb;
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

    #5 we_tb = 0;

    for(i = 0; i < 3; i=i+1)
      #20 raddr_tb = i;

    #10 we_tb = 1;
    be_tb = 4'b0001;
    wdata_tb = 32'b11111111111111111111111111111111;
    
    waddr_tb = 0;
    #10
    waddr_tb = 1;//8'b00000001;
    raddr_tb = 0;
    #10
    waddr_tb = 2;//8'b00000010;
    raddr_tb = 1;
    #10
    raddr_tb = 2;
    #10

    #30 $finish;
  end

  initial begin
    clk_tb <= 1'b1;
    forever
      #5 clk_tb <= ~clk_tb;
  end

endmodule
