`timescale 100ns / 10ns

`define WIDTH 32

module bus_interconnect_tb;

  reg clk_tb;
  reg [`WIDTH-1:0] addr_tb;
  reg [`WIDTH-1:0] rdata_gpio_tb;
  reg [`WIDTH-1:0] rdata_ram_tb;
  reg we_tb;
  wire [`WIDTH-1:0] rdata_tb;
  wire we_ram_tb;
  wire we_gpio_tb;

  bus_interconnect uut(
    .clk(clk_tb),
    .addr(addr_tb),
    .rdata_gpio(rdata_gpio_tb),
    .rdata_ram(rdata_ram_tb),
    .we(we_tb),
    .rdata(rdata_tb),
    .we_ram(we_ram_tb),
    .we_gpio(we_gpio_tb) 
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;

    #10
    addr_tb = 32'd10;
    #10
    rdata_gpio_tb = 32'd12;
    #10
    addr_tb = {32{1'bx}};
    #10
    rdata_ram_tb = 32'd8;
    #10
    we_tb = 1;
    #10
    rdata_gpio_tb = 32'd12;
    #10
    rdata_ram_tb = 32'd8;
    #10
    rdata_ram_tb = 32'd1024;
    #10
    we_tb = 0;
    #10
    rdata_gpio_tb = 32'd12;
    #10
    addr_tb = {32{1'bx}};
    #10
    rdata_ram_tb = 32'd8;
    #10
    addr_tb = 32'd3;
    #10
    rdata_gpio_tb = 32'd5;
    #10
    rdata_ram_tb = 32'd2;
    #10
    rdata_gpio_tb = 32'd4;
    #10
    rdata_ram_tb = 32'd0;
    #10
    rdata_gpio_tb = 32'd3;
    we_tb = 1;
    #10
    we_tb = 0;
    #10
    addr_tb = {32{1'bx}};
    #10
    rdata_gpio_tb = 32'd12;
    #100
    ///////////
    addr_tb = 32'd0;
    we_tb = 1;   
    #20
    we_tb = 0;
    #20
    ///////////
    addr_tb = 32'd2;
    we_tb = 1;   
    #20
    we_tb = 0;
    #20
    ///////////
    addr_tb = 32'b00100000000000000000000000000000;
    we_tb = 1;   
    #20
    we_tb = 0;
    #20
    ///////////
    addr_tb = 32'd0;
    we_tb = 1;   
    #20
    we_tb = 0;
    #20   

    #50 $finish;
  end

  initial begin
    clk_tb <= 1'b1;
    forever
      #5 clk_tb <= ~clk_tb;
  end

endmodule
