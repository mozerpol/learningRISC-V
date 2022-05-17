/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`timescale 100ns / 10ns

module rysy_tb #(parameter CODE="blink_slow.mem");

  reg clk;
  reg rst;
  wire [3:0] gpio;

  initial begin
    clk = 1'b1;
    forever
      # 5 clk = ~clk;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    rst <= 1'b0;
    #25 rst <= 1'b1;

    #100 $finish;
  end

  rysy #(
    .CODE(CODE)
  ) dut(
    .clk(clk),
    .rst(rst),
    .gpio(gpio)
  );

endmodule
