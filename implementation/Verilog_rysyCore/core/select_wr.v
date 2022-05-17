/*
	How it works...
    Block select_wr is responsible for preparing data for WDATA part. "select_wr" is
    setting bits for saving data and preparing "be" singal. If we want to save the whole
    word to memory then be signal has four bits set on 1, if we want to save the half
    word to memory then be signal is set on: 0011, if we want to save the half word to
    memory then be signal is set on: 0001.
*/
`timescale 100ns/10ns
`include "rysy_pkg.vh"
`include "select_wr.vh"

module select_wr(
  input wire [`REG_LEN-1:0] rs2_d, // Machine word from reg_file
  input wire [2:0] sel_type, // Which storage instruction select, SB, SH or SHU...?
  input wire [1:0] sel_addr, // Select write whole word, half word, ...
  output wire [3:0] be, // be - byte enable, allows to write those bytes from the word, 
  // whose bits are set. 
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
