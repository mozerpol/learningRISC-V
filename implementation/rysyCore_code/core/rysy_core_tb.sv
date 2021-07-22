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

    #5;
    rst_tb = 1;
    #10
    /*
    	....:::::rst_tb = 0;:::::....
    	pc_reg	in 	mem_addr_sel 	= 	0
        inst  	in	inst_mgmt		=	32'h00000013 (32'b10011)
    */
    rst_tb = 0;
    /*
    						Test for OP-IMM family
    
    	....:::::rdata_tb = 32'b000000000011_00001_000_00010_0010011;:::::....
        After two cycles inst in inst_mgmt will have rdata_tb value
    */
    rdata_tb = 32'b000000000011_00001_000_00010_0010011;


    #30; $finish;   
  end

  always #5 clk_tb = ~clk_tb;

endmodule
