`timescale 100ns / 10ns

`include "rysy_pkg.vh"

module reg_file
  #(parameter ADDR_LEN = 5) (
    input wire [ADDR_LEN-1:0]rs1,
    input wire [ADDR_LEN-1:0]rs2,
    input wire [ADDR_LEN-1:0]rd,
    input wire [`REG_LEN-1:0]rd_d,
    input wire reg_wr,
    input wire clk,
    output wire [`REG_LEN-1:0]rs1_d,
    output wire [`REG_LEN-1:0]rs2_d
  );

  reg [`REG_LEN-1:0] x[`REG_NUM-1:0];

  assign rs1_d = (rs1 == 0) ? 32'd0 : x[rs1];
  assign rs2_d = (rs2 == 0) ? 32'd0 : x[rs2];

  always@(posedge clk)
    begin
      if(reg_wr) x[rd] <= rd_d;
    end

endmodule
