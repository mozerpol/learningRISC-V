/*
 * Mozerpol 2021
 */

`timescale 100ns / 10ns

module alu1_mux_tb;

  reg [REG_LEN:0] rs1_d_tb;
  reg [REG_LEN:0] pc_tb;
  reg alu1_sel_tb;
  reg clk_tb;
  reg [REG_LEN:0] alu_in1_tb;

  alu1_mux uut(
    .rs1_d(rs1_d_tb),
    .pc(pc_tb),
    .clk(clk_tb),
    .alu1_sel(alu1_sel_tb),
    .alu_in1(alu_in1_tb)
  );

  reg [31:0] val_for_rs1_d [0:4]; // 4 x 32-bit
  reg [31:0] val_for_pc [0:5];
  integer i;

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    val_for_rs1_d[0] = 32'd10;
    val_for_rs1_d[1] = 32'd3;
    val_for_rs1_d[2] = -32'd4;
    val_for_rs1_d[3] = 32'd4;
    val_for_rs1_d[4] = -32'd16;

    val_for_pc[0] = 32'd0;
    val_for_pc[1] = 32'd1;
    val_for_pc[2] = 32'd2;
    val_for_pc[3] = 32'd10;
    val_for_pc[4] = -32'd16;
    val_for_pc[5] = -32'd4;

    clk_tb = 0; // start clk

    alu1_sel_tb = 1'b0; // checking working for ALU1_RS
    for(i = 0; i < 5; i=i+1) 
      #10 rs1_d_tb = val_for_rs1_d[i];

    alu1_sel_tb = 1'b1; // checking working for ALU1_PC
    for(i = 0; i < 6; i=i+1) 
      #10 pc_tb = val_for_pc[i];

    #25 $finish;
  end

  always #5 clk_tb = ~clk_tb;

endmodule

