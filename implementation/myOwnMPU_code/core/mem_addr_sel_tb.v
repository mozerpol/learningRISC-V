/*
	Mozerpol
*/
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
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 1:                               //
    // Test for first mux. Take address from ALU and pass it to the   //
    // output of mux. We have several 32bit values, which simulate    //
    // the values from ALU. Output for first mux is "pc".	          //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b00; // Take address from ALU.
    alu_out_tb = 32'd10;
    #10 alu_out_tb = 32'd3;
    #10 alu_out_tb = -32'd4;
    #10 alu_out_tb = 32'd4;
    #10 alu_out_tb = -32'd16;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 2:                               //
    // Test for first mux. Just add number 4 for current PC value.    //
    // Output for first mux is "pc". We can notice that current value //	
    // is "-32'd16", which means in hex "ffff_fff0". After 			  //
    // incrementation PC reg by 4, we will get "ffff_fff4".	After one //
    // incrementation of "ffff_fffc" value we have 0, because PC reg  //
    // can store only 32 bits, it means max falue is ffff_ffff, after //
    // overflow we start count from 0.								  //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b01; // Increment actual value in PC
    #50; // Increment 6 times, because 10+50=60, it means 6 clock cycles
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 3:                               //
    // Test for first mux. Point to the previous instruction. Do the  //
    // same as in incrementation, but in the other direction ;p       //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b10; // Decrement actual value in PC six times
    #50;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 4:                               //
    // Test for first mux. Do the same as in first test, but put in   //
    // the middle reset.                         				      //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b00; // Take address from ALU.
    alu_out_tb = 32'd10;
    #10 alu_out_tb = 32'd3;
    #10 rst_tb = 1;
    #10 alu_out_tb = 32'd9;
    #30 rst_tb = 0;
    #10 alu_out_tb = 32'd4;
    #10 alu_out_tb = -32'd16;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 5:                               //
    // Test for first mux. Generally do nothing, just save in PC reg  //
    // its actual value.    									      //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b11;
    #50;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 6:                               //
    // Test for second mux. The output from "mux_mem_addr" module     //
    // will be value from PC reg.                                     //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 mem_sel_tb = 1'b0;
    
    #20 alu_out_tb = 32'd10;
    mem_sel_tb = 1'b1;
    
    #10 alu_out_tb = 32'd3;
    #10 rst_tb = 1;
    #30 rst_tb = 0;
    #10 alu_out_tb = -32'd4;
    #10 alu_out_tb = 32'd4;
    #10 alu_out_tb = -32'd16;

    #20 $finish;
  end

  always #5 clk_tb = ~clk_tb;

endmodule
