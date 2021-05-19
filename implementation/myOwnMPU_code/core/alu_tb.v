`include "rysy_pkg.vh"
`timescale 100ns / 10ns

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

    for(a = 0; a < 10; a++)
      begin
        $display ("Current operation: %b", a);
        
        for(i = 0; i < 5; i++)
          begin
            #10
            alu_in1_tb = val_for_in1[i];
            alu_in2_tb = val_for_in2[i];
            alu_op_tb = a;
            #10
            $display ("%d | val_for_in1: %d | val_for_in2: %d | result: %d |", 
                      i, val_for_in1[i], val_for_in2[i], alu_out_tb);
          end
      end

    #50 $finish;
  end

endmodule
