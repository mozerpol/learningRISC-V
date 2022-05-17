/*
   * Mozerpol 2021
  */

`timescale 100ns / 10ns

module imm_mux_tb;

  reg [2:0] imm_type_tb;
  reg [31:0] imm_J_tb;
  reg [31:0] imm_U_tb;
  reg [31:0] imm_B_tb;
  reg [31:0] imm_S_tb;
  reg [31:0] imm_I_tb;
  wire [31:0] imm_tb;

  imm_mux uut(
    .imm_type(imm_type_tb),
    .imm_J(imm_J_tb),
    .imm_U(imm_U_tb),
    .imm_B(imm_B_tb),
    .imm_S(imm_S_tb),
    .imm_I(imm_I_tb),
    .imm(imm_tb) // otput from our module
  );

  integer i, j; // var for loop purposes
  reg [31:0] val_for_imm[0:4];

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    imm_type_tb = 3'b000;
    imm_J_tb = 32'd10;
    #5 imm_J_tb = 32'd3;
    #5 imm_J_tb = -32'd4;
    #5 imm_J_tb = 32'd4;
    #5 imm_J_tb = -32'd16;

    #5 imm_type_tb = 3'b001;
    imm_U_tb = 32'd10;
    #5 imm_U_tb = 32'd3;
    #5 imm_U_tb = -32'd4;
    #5 imm_U_tb = 32'd4;
    #5 imm_U_tb = -32'd16;

    #5 imm_type_tb = 3'b010;
    imm_B_tb = 32'd10;
    #5 imm_B_tb = 32'd3;
    #5 imm_B_tb = -32'd4;
    #5 imm_B_tb = 32'd4;
    #5 imm_B_tb = -32'd16;

    #5 imm_type_tb = 3'b011;
    imm_S_tb = 32'd10;
    #5 imm_S_tb = 32'd3;
    #5 imm_S_tb = -32'd4;
    #5 imm_S_tb = 32'd4;
    #5 imm_S_tb = -32'd16;

    #5 imm_type_tb = 3'b100;
    imm_I_tb = 32'd10;
    #5 imm_I_tb = 32'd3;
    #5 imm_I_tb = -32'd4;
    #5 imm_I_tb = 32'd4;
    #5 imm_I_tb = -32'd16;
  end

endmodule
