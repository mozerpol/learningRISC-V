/*
 * Mozerpol 2021
 */

`timescale 100ns / 10ns

module cmp_tb;
  reg[31:0] rs1_d_tb;
  reg[31:0] rs2_d_tb;
  reg [2:0] cmp_op_tb;
  reg b_tb; // result, output cmp module

  cmp uut(
    .rs1_d(rs1_d_tb),
    .rs2_d(rs2_d_tb),
    .cmp_op(cmp_op_tb),
    .b(b_tb)
  );

  reg [31:0] val_for_rs1_d [0:4];
  reg [31:0] val_for_rs2_d [0:4];
  reg [15:0] equation [0:5];
  integer i, j, k; // var for loop purposes

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

    equation[0] = "==";
    equation[1] = "!=";
    equation[2] = "<";
    equation[3] = ">=";
    equation[4] = "<";
    equation[5] = ">=";

    $display("Hint how operators work in Verilog:");
    $display("\n\n 1==1: %d | 1==2: %d \
    | 1!=1: %d | 1!=2: %d \
    | 1<1: %d | 1<2: %d | 2<1: %d \
    | 1>=1: %d | 1>=2: %d | 2>=1: %d", 
             (1==1), (1==2), 
             (1!=1), (1!=2), 
             (1<1), (1<2), (2<1), 
             (1>=1), (1>=2), (2>=1));

    for(i = 0; i < 6; i=i+1) // loop for selecting operator type
      begin
        #5 cmp_op_tb = i; // these dalays are for simulation purposes, without delay,
        // simulation works weird.
        for(j = 0; j < 5; j=j+1) // loop for assigning values to val_for_rs1_d
          begin
            for(k = 0; k < 5; k=k+1) // loop for assigning values to val_for_rs2_d
              begin
                #5 rs1_d_tb = val_for_rs1_d[j];
                #5 rs2_d_tb = val_for_rs2_d[k];
                #5 $display (" %d         %s %d      result: %b", 
                             rs1_d_tb, equation[i], rs2_d_tb, b_tb);
              end
          end
      end
    $display("\n");

    #25 $finish;
  end

endmodule

