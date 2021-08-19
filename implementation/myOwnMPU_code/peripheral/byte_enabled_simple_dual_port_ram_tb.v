`timescale 100ns / 10ns

`define WIDTH 32

module simple_dual_port_ram_single_clock_ut;

  reg clk_tb;
  reg we_tb;
  reg [31:0] wdata_tb;
  reg [3:0] be_tb;
  reg [7:0] waddr_tb;
  reg [7:0] raddr_tb;
  wire [31:0] q_tb;

  simple_dual_port_ram_single_clock uut(
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

    we_tb = 0; 
    #5;

    for(i = 0; i < 5; i=i+1)
      begin
        raddr_tb = i;
        #10;
      end

    we_tb = 1;
    be_tb = 4'b0001; // We'll modify last two octets
    wdata_tb = 32'b11111111_11111111_11111111_11111111;
    #20

    for(i = 0; i < 5; i=i+1)
      begin
        waddr_tb = i; // Select address to save data
        #10;
        raddr_tb = i; // Select address to write data
        #10;
      end

    be_tb = 4'b0100;
    #20

    for(i = 0; i < 5; i=i+1)
      begin
        waddr_tb = i;
        #10;
        raddr_tb = i;
        #10;
      end

    be_tb = 4'b0101;
    wdata_tb = 32'b11111111_00000000_11111111_00000000;
    #20

    for(i = 0; i < 5; i=i+1)
      begin
        waddr_tb = i;
        #10;
        raddr_tb = i;
        #10;
      end

    #20 $finish;
  end

  initial begin
    clk_tb <= 1'b1;
    forever
      #5 clk_tb <= ~clk_tb;
  end

endmodule
