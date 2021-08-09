/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`timescale 100ns / 10ns

module gpio (
  input wire [7:0] addr,
  input wire [3:0] be,
  input wire [31:0] wdata,
  input wire we,
  input wire clk,
  input wire rst,
  output wire [31:0] q,
  output wire [3:0] gpio
);

  reg [31:0] gpio_state;

  always@(posedge clk) begin
    if (rst)
      gpio_state <= {32{1'b0}};
    else if(we && addr == {32{1'b0}})
      gpio_state <= wdata;
  end

  assign gpio = ~gpio_state[3:0];
  assign q = gpio_state;
endmodule
