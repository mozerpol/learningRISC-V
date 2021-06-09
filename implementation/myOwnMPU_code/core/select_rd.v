/*
	How "select_rd" module works. It's responsible for downloading data from memory, exactly
    which bytes may be read from memory. At the beginning we must explain a few things. 
    1. PC reg points to memory address where is instruction to execution. For example PC reg
    can store value 0x0004, which points to 0x04 address in memory where we have instruction
    0x1234.
    2. ADDR reg stores memory address where is instruction to execution, so ADDR do the same
    as PC reg. But the difference is in ADDR we can store address after some calculations by
    ALU.
    3. RDATA reg in the next clock cycle (after placing the value in ADDR) will store instruction
    to execution. So, ADDR holds the address 0x0004, RDATA holds the instruction 0x1234.
*/
`timescale 100ns/10ns
`include "rysy_pkg.vh"

// SB, SH, ... are S-type instructions, storage instructions.
`define SB  3'b000
`define SH  3'b001
`define SW  3'b010
`define SBU 3'b011
`define SHU 3'b100

module select_rd(
  input wire [`REG_LEN-1:0] rdata, // Instruction to execution from RDATA reg, rd_d on the picture
  input wire [2:0] sel_type, // Which storage instruction select, SB, SH or SHU...?
  input wire [1:0] sel_addr_old,
  output wire [`REG_LEN-1:0] rd_mem
);

  reg [`REG_LEN-1:0] o;
  assign rd_mem = o;

  always@(*)
    case(sel_type)
      `SB:
        case(sel_addr_old)
          // The {} operator means concatenation of two numbers. E.g. {2'b01, 2'b11} is equal 4'b0111.
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
