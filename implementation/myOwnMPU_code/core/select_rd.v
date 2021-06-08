`timescale 100ns / 10ns
`include "rysy_pkg.vh"

`define SB  3'b000
`define SH  3'b001
`define SW  3'b010
`define SBU 3'b011
`define SHU 3'b100

module select_rd(
  input wire [`REG_LEN-1:0] rdata,
  input wire [2:0] sel_type,
  input wire [1:0] sel_addr_old,
  output wire [`REG_LEN-1:0] rd_mem
);
  
  reg [`REG_LEN-1:0] o;
  assign rd_mem = o;

  always@(*)
    case(sel_type)
      `SB:
        case(sel_addr_old)
          2'b00: o = {rdata[7] ? 24'hffffff : 24'h0, rdata[7:0]};
          2'b01: o = {rdata[15] ? 24'hffffff : 24'h0, rdata[15:8]};
          2'b10: o = {rdata[23] ? 24'hffffff : 24'h0, rdata[23:16]};
          2'b11: o = {rdata[31] ? 24'hffffff : 24'h0, rdata[31:24]};
          default: o = 32'b0;
        endcase
      `SH:
        case(sel_addr_old)
          2'b00: o = {rdata[15] ? 16'hffff : 16'h0, rdata[15:0]};
          2'b10: o = {rdata[31] ? 16'hffff : 16'h0, rdata[31:16]};
          default: o = 32'b0;
        endcase
      `SW: o = rdata;
      `SBU:
        case(sel_addr_old)
          2'b00: o = {24'h0, rdata[7:0]};
          2'b01: o = {24'h0, rdata[15:8]};
          2'b10: o = {24'h0, rdata[23:16]};
          2'b11: o = {24'h0, rdata[31:24]};
          default: o = 32'b0;
        endcase
      `SHU:
        case(sel_addr_old)
          2'b00: o = {16'h0, rdata[15:0]};
          2'b10: o = {16'h0, rdata[31:16]};
          default: o = 32'b0;
        endcase
      default: o = 32'b0;
    endcase

endmodule
