`timescale 100ns / 10ns

module mem_addr_sel_tb;

  reg clk_tb = 1;
  reg rst_tb;
  reg [1:0] pc_sel_tb;
  reg mem_sel_tb;
  reg [31:0] alu_out_tb;
  wire [31:0] addr_tb;
  
  mem_addr_sel uut(
    .clk(clk_tb),
    .rst(rst_tb),
    .pc_sel(pc_sel_tb),
    .alu_out(alu_out_tb),
    .addr(addr_tb),
    .mem_sel(mem_sel_tb)
  );
  
  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;
    
    rst_tb = 0;
    #5 pc_sel_tb = 2'b01;
    
    #50 $finish;
  end

  always #5 clk_tb = ~clk_tb;
  
endmodule
