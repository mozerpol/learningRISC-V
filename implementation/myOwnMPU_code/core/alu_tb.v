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


  reg [31:0] val_for_in1 [0:4]; // 4 x 32-bit
  reg [31:0] val_for_in2 [0:4];
  integer i;
  reg [0:3] a;

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    val_for_in1[0] = 32'd10;
    val_for_in1[1] = 32'd3;
    val_for_in1[2] = -32'd4;
    val_for_in1[3] = 32'd4;
    val_for_in1[4] = -32'd16;

    val_for_in2[0] = 32'd2;
    val_for_in2[1] = 32'd10;
    val_for_in2[2] = 32'd4;
    val_for_in2[3] = -32'd4;
    val_for_in2[4] = 32'd2;


//     $display ("val_for_in1: %d", val_for_in1[2]);
//     $display ("val_for_in2: %d", val_for_in2[2]);

    for(a = 0; a < 10; a++)
      begin
        $display ("i: %b", a);

        for(i = 0; i < 5; i++)
          begin
            $display ("val_for_in1: %d", val_for_in1[i]);
            $display ("val_for_in2: %d", val_for_in2[i]);
          end
      end

    #50 $finish;
  end

endmodule

