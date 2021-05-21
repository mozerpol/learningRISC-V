/*
 * Mozerpol 2021
 */

`timescale 100ns / 10ns

module alu2_mux_tb;

  reg [31:0] rs2_d_tb;
  reg [31:0] imm_tb;
  reg alu2_sel_tb;
  wire [31:0] alu_in2_tb;

  alu2_mux uut(
    .rs2_d(rs2_d_tb),
    .imm(imm_tb),
    .alu2_sel(alu2_sel_tb),
    .alu_in2(alu_in2_tb) // otput from our module
  );

  reg [31:0] val_for_rs2_d [0:4]; // 4 x 32-bit
  reg [31:0] val_for_imm [0:5];
  integer i; // var for loop purposes

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    val_for_rs2_d[0] = 32'd10;
    val_for_rs2_d[1] = 32'd3;
    val_for_rs2_d[2] = -32'd4;
    val_for_rs2_d[3] = 32'd4;
    val_for_rs2_d[4] = -32'd16;

    val_for_imm[0] = 32'd0;
    val_for_imm[1] = 32'd1;
    val_for_imm[2] = 32'd2;
    val_for_imm[3] = 32'd10;
    val_for_imm[4] = -32'd16;
    val_for_imm[5] = -32'd4;

    alu2_sel_tb = 1'b0; // checking working for ALU2_RS
    for(i = 0; i < 5; i=i+1) 
      #10 rs2_d_tb = val_for_rs2_d[i];

    #10 alu2_sel_tb = 1'b1; // checking working for ALU2_IMM
    for(i = 0; i < 6; i=i+1) 
      #10 imm_tb = val_for_imm[i];

    #25 $finish;
  end

endmodule

