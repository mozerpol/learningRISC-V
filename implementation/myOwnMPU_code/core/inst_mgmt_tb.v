/*
   * Mozerpol 2021
 
*/

`timescale 100ns / 10ns

module inst_mgmt_tb;

  reg clk_tb = 1;
  reg rst_tb;
  reg [31:0] rdata_tb;
  reg [1:0] inst_sel_tb;
  wire [31:0] inst_tb;

  inst_mgmt uut(
    .clk(clk_tb),
    .rst(rst_tb),
    .rdata(rdata_tb),
    .inst_sel(inst_sel_tb),
    .inst(inst_tb) // otput from our module
  );

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;
    
    rst_tb = 0;
    #5 
    
	#5 $finish;
  end

  always #5 clk_tb = ~clk_tb;

endmodule
 
