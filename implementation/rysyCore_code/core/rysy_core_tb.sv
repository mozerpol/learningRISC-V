/*
	By Mozerpol
*/

module rysy_core_tb;
  reg clk_tb = 1'b1;
  reg rst_tb;
  reg [31:0] rdata_tb;
  wire [31:0] wdata_tb;
  wire [31:0] addr_tb;
  wire we_tb;
  wire [3:0] be_tb;

  rysy_core dut(
    .clk(clk_tb),
    .rst(rst_tb),
    .rdata(rdata_tb),
    .wdata(wdata_tb),
    .addr(addr_tb),
    .we(we_tb),
    .be(be_tb)
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;

    #10; $finish;   
  end

  always #5 clk_tb = ~clk_tb;

endmodule
