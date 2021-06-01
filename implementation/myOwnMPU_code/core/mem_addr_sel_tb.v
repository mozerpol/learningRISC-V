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
    // Move instructions from output to input (instruction comes from //
    // RDATA reg). Look at the core structure                         //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b00; // Value to the PC from ALU
    alu_out_tb = 32'd10;
    #10 alu_out_tb = 32'd3;
    #10 alu_out_tb = -32'd4;
    #10 alu_out_tb = 32'd4;
    #10 alu_out_tb = -32'd16;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 1:                               //
    // Move instructions from output to input (instruction comes from //
    // RDATA reg). Look at the core structure                         //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b01; // Increment actual value in PC
    #50; 
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 1:                               //
    // Move instructions from output to input (instruction comes from //
    // RDATA reg). Look at the core structure                         //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b10; // Decrement actual value in PC
    #100;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 1:                               //
    // Move instructions from output to input (instruction comes from //
    // RDATA reg). Look at the core structure                         //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b00; // Value to the PC from ALU
    alu_out_tb = 32'd10;
    #10 alu_out_tb = 32'd3;
    #10 rst_tb = 1;
    #30 rst_tb = 0;
    #10 alu_out_tb = -32'd4;
    #10 alu_out_tb = 32'd4;
    #10 alu_out_tb = -32'd16;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 1:                               //
    // Move instructions from output to input (instruction comes from //
    // RDATA reg). Look at the core structure                         //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 pc_sel_tb = 2'b11;
    #50;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 1:                               //
    // Move instructions from output to input (instruction comes from //
    // RDATA reg). Look at the core structure                         //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
    #10 mem_sel_tb = 1'b0;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 1:                               //
    // Move instructions from output to input (instruction comes from //
    // RDATA reg). Look at the core structure                         //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//    
    #20 alu_out_tb = 32'd10;
    mem_sel_tb = 1'b1;
    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//
    //                          Test 1:                               //
    // Move instructions from output to input (instruction comes from //
    // RDATA reg). Look at the core structure                         //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,//
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
