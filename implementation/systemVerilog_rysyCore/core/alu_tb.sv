/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 * A bit modified by Mozerpol
 */

`default_nettype none
`timescale 100ns / 10ns

module alu_tb;
  logic [31:0]in1;
  logic [31:0]in2;
  logic [31:0]out;
  aluPkg::alu_op op;

  alu dut (
    .alu_in1(in1),
    .alu_in2(in2),
    .alu_op(op),
    .alu_out(out)
  );

  int i;
  logic [31:0]in1_a[] = {32'd10, 32'd3, -32'd4, 32'd4, -32'd16};
  logic [31:0]in2_a[] = {32'd2, 32'd10, 32'd4, -32'd4, 32'd2};
  int N = ($size(in1_a) > $size(in2_a)) ? $size(in2_a) : $size(in1_a);

  initial begin
    $dumpfile("tb.vcd"); 
    $dumpvars;

    op = op.first;

    do begin      
      $display ("\nCurrent operation: %b", op);
      #10

      for (i = 0; i < N; i++) begin
        in1 = in1_a[i];
        in2 = in2_a[i];
        #10
        $display ("In1 value: %d | In2 value: %d | result: %d |", in1, in2, out);
      end
      op = op.next;
    end while (op != op.first);

  end
endmodule

`default_nettype wire
