`timescale 100ns / 10ns

module gpio_tb;

  reg [7:0]addr;
  reg [3:0]be;
  reg [31:0]wdata;
  reg we;
  reg clk;
  reg rst;
  wire [31:0]q;
  wire [3:0]gpio;

  gpio uut( .*);

  initial begin

    #10 $finish;
  end

  initial begin
    clk <= 1'b1;
    forever
      #5 clk <= ~clk;
  end

endmodule
