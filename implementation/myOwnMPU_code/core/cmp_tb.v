/*
 * Mozerpol 2021
 */

`timescale 100ns / 10ns

module cmp_tb;
  reg[31:0] rs1_d_tb;
  reg[31:0] rs2_d_tb;
  reg [2:0] cmp_op_tb;
  reg b_tb;

  cmp uut(
    .rs1_d(rs1_d_tb),
    .rs2_d(rs2_d_tb),
    .cmp_op(cmp_op_tb),
    .b(b_tb)
  );

  reg [31:0] val_for_rs1_d;
  reg [31:0] val_for_rs2_d;
  integer i; // var for loop purposes

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    val_for_rs1_d[0] = 32'd10;
    val_for_rs1_d[1] = 32'd3;
    val_for_rs1_d[2] = -32'd4;
    val_for_rs1_d[3] = 32'd4;
    val_for_rs1_d[4] = -32'd16;

    val_for_rs2_d[0] = 32'd10;
    val_for_rs2_d[1] = 32'd3;
    val_for_rs2_d[2] = -32'd4;
    val_for_rs2_d[3] = 32'd4;
    val_for_rs2_d[4] = -32'd16;
    
    
    
    #25 $finish;
  end

endmodule

