`include "rysy_pkg.vh"
`timescale 1ns / 1ns

module alu_tb;

  reg [`REG_LEN-1:0] alu_in1_tb;
  reg [`REG_LEN-1:0] alu_in2_tb;
  reg [3:0] alu_op_tb;
  wire [`REG_LEN-1:0] alu_out_tb;

  alu uut(
    .alu_in1(alu_in1_tb),
    .alu_in2(alu_in2_tb),
    .alu_op(alu_op_tb),
    .alu_out(alu_out_tb)
  );

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    alu_in1_tb = 32'b01;
    alu_in2_tb = 32'b10;
    alu_op_tb = 4'b0000;

    #50
    alu_in1_tb = 32'b0;
    alu_in2_tb = 32'b0;
    #50 $finish;
  end

endmodule

