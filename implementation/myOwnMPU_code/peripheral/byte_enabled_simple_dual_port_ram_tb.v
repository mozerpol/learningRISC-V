`timescale 100ns / 10ns

`define WIDTH 32

module bus_interconnect_tb;

  reg clk_tb;

  byte_enabled_simple_dual_port_ram uut(
    .clk(clk_tb)
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    
    #50 $finish;
  end

  initial begin
    clk_tb <= 1'b1;
    forever
      #5 clk_tb <= ~clk_tb;
  end

endmodule
