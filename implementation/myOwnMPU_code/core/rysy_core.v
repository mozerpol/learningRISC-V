/*
	By Mozerpol
*/

`timescale 100ns / 10ns

`include "opcodes.vh"
`include "instruction.v"
`include "rysy_pkg.vh"
`include "inst_mgmt.v"
`include "imm_mux.v"
`include "alu.v"
`include "cmp.v"
`include "mem_addr_sel.v"
`include "rd_mux.v"
`include "alu1_mux.v"
`include "alu2_mux.v"
`include "select_pkg.v"
`include "decode.v"
`include "select_rd.v"
`include "reg_file.v"
`include "select_wr.v"
`include "ctrl.v"

module rysy_core (
  input wire clk, // alu1_mux, ctrl, inst_mgmt, mem_addr_sel, rd_mux, reg_file, 
  input wire rst, // ctrl, inst_mgmt, mem_addr_sel
  input wire [`REG_LEN-1:0] rdata, // inst_mgmt, select_rd, select_wr 
  output wire [`REG_LEN-1:0] wdata, // select_wr
  output wire [`REG_LEN-1:0] addr, // mem_addr_sel, mux
  output wire we, // ctrl
  output wire [3:0] be // select_wr
);
  
endmodule
