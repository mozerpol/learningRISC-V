/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`include "opcodes.sv"
`include "instruction.sv"
`include "rysy_pkg.sv"
`include "inst_mgmt.sv"
`include "imm_mux.sv"
`include "alu.sv"
`include "cmp.sv"
`include "mem_addr_sel.sv"
`include "rd_mux.sv"
`include "alu1_mux.sv"
`include "alu2_mux.sv"
`include "select_pkg.sv"
`include "decode.sv"
`include "select_rd.sv"
`include "reg_file.sv"
`include "select_wr.sv"
`include "ctrl.sv"

`default_nettype none

import rysyPkg::*;

module rysy_core (
  input wire clk, // alu1_mux, ctrl, inst_mgmt, mem_addr_sel, rd_mux, reg_file, 
  input wire rst, // ctrl, inst_mgmt, mem_addr_sel
  input wire [REG_LEN-1:0]rdata, // inst_mgmt, select_rd, select_wr 
  output logic [REG_LEN-1:0]wdata, // select_wr
  output logic [REG_LEN-1:0]addr, // mem_addr_sel, mux
  output logic we, // ctrl
  output logic [3:0]be // select_wr
);

  pcPkg::pc_sel pc_sel; // mem_addr_sel
  pcPkg::mem_sel mem_sel;
  wire [REG_LEN-1:0]pc;
  wire [REG_LEN-1:0]inst;
  instMgmtPkg::inst_sel inst_sel; // inst_mgmt

  rdPkg::rd_sel rd_sel; // rd_mux
  wire [ADDR_LEN-1:0]rs1;
  wire [ADDR_LEN-1:0]rs2;
  wire [ADDR_LEN-1:0]rd;
  wire [REG_LEN-1:0]rs1_d;
  wire [REG_LEN-1:0]rs2_d;
  wire reg_wr;
  wire [REG_LEN-1:0]rd_d;

  alu1Pkg::alu1_sel alu1_sel; // alu1_mux
  wire [REG_LEN-1:0]alu_in1;
  alu2Pkg::alu2_sel alu2_sel; // alu2_mux
  wire [REG_LEN-1:0]alu_in2;
  wire [REG_LEN-1:0]alu_out;
  aluPkg::alu_op alu_op; // alu

  cmpPkg::cmp_op cmp_op; // cmp
  logic b;

  immPkg::imm_type imm_type; // imm_mux
  wire [REG_LEN-1:0]imm_I;
  wire [REG_LEN-1:0]imm_S;
  wire [REG_LEN-1:0]imm_B;
  wire [REG_LEN-1:0]imm_U;
  wire [REG_LEN-1:0]imm_J;
  wire [REG_LEN-1:0]imm;

  opcodePkg::opcode opcode; // opcodes
  wire [2:0]func3;
  wire [6:0]func7;

  selectPkg::sel_type sel_type; // select_pkg
  wire [1:0]sel_addr;
  logic [1:0]sel_addr_old;
  wire [REG_LEN-1:0]rd_mem;

  assign sel_addr = addr[1:0];
  always_ff @(posedge clk)
    sel_addr_old <= sel_addr;

  mem_addr_sel mem_addr_sel_1 (.*);
  inst_mgmt inst_mgmt_1 (.*);
  decode decode_1 (.*);
  imm_mux imm_mux1 (.*);
  select_rd select_rd1(.*);
  reg_file reg_file1 (.*);
  rd_mux rd_mux1 (.*);
  alu1_mux alu1_mux1 (.*);
  alu2_mux alu2_mux1 (.*);
  alu alu1 (.*);
  cmp cmp1 (.*);
  select_wr select_wr1 (.*);

  ctrl c (.*);
endmodule

`default_nettype wire
