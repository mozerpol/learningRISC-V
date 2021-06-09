`timescale 100ns/10ns
`include "rysy_pkg.vh"

// SB, SH, ... are S-type instructions, storage instructions.
`define SB  3'b000
`define SH  3'b001
`define SW  3'b010
`define SBU 3'b011
`define SHU 3'b100

module select_wr(
  input wire [`REG_LEN-1:0] rs2_d,
  input wire [2:0] sel_type,
  input wire [1:0] sel_addr,
  output wire [3:0] be,
  output wire [`REG_LEN-1:0] wdata
);

  reg [`REG_LEN-1:0] o_wdata;
  assign wdata = o_wdata;
  reg [3:0] o_be;
  assign be = o_be;

  always@(*)
    case (sel_type)
      `SB:
        case (sel_addr)
          2'b00: o_wdata = {24'b0, rs2_d[7:0]};
          2'b01: o_wdata = {16'b0, rs2_d[7:0], 8'b0};
          2'b10: o_wdata = {8'b0, rs2_d[7:0], 16'b0};
          2'b11: o_wdata = {rs2_d[7:0], 24'b0};
          default: o_wdata = {24'b0, rs2_d[7:0]};
        endcase
      `SH:
        case (sel_addr)
          2'b00: o_wdata = {16'b0, rs2_d[15:0]};
          2'b10: o_wdata = {rs2_d[15:0], 16'b0};
          default: o_wdata = {16'b0, rs2_d[15:0]};
        endcase
      `SW: o_wdata = rs2_d;
      default: o_wdata = rs2_d;
    endcase

  always@(*)
    case(sel_type)
      `SB : o_be = 4'b0001 << sel_addr;
      `SH : o_be = 4'b0011 << sel_addr;
      `SW : o_be = 4'b1111;
      default: o_be = 4'b1111;
    endcase

endmodule
