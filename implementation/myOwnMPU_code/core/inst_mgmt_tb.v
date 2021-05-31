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
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 1:                               //
    // Move instructions from output to input (instruction comes from //
    // RDATA reg). Look at the core structure                         //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 inst_sel_tb = `INST_MEM;
    rdata_tb = 32'd11;
    #10 rdata_tb = 32'd3;
    #10 rdata_tb = -32'd4;
    #10 rdata_tb = 32'd4;
    #10 rdata_tb = -32'd16;
    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                                Test 2:                                //
    // We have previous instruction on output. In this case will be -32'd16  //
    // which is equal in signed 2's complement notation fffffff0.            //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 inst_sel_tb = `INST_OLD;
    //'''''''''''''''''''''''''''''''''''''''''''//
    //                  Test 3:                  //
    // NOP on output. NOP is equal 32'h00000013. //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 inst_sel_tb = `INST_NOP; // Fistr clock cycle
    #10 inst_sel_tb = `INST_NOP; // Second clock cycle
    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                                Test 3:                                    //
    // Move instructions from output to input (instruction comes from RDATA      //
    // reg). Look at the core structure. In the middle reset the processor.      //
    // During reset on output should be NOP. After the end of reset, instruction //
    // from RDATA reg will appear in next two cycles, because first clock cycle  //
    // is for exits from the conditional statement: if(rst) o <= NOP;            //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 inst_sel_tb = `INST_MEM;
    rdata_tb = 32'd11;
    #10 rdata_tb = 32'd3;
    #10 rst_tb = 0;
    #10 rst_tb = 1;
    #30 rst_tb = 0;
    #10 rdata_tb = -32'd4;
    #10 rdata_tb = 32'd4;
    #10 rdata_tb = -32'd16;

    #10 $finish;
  end

  always #5 clk_tb = ~clk_tb;

endmodule
