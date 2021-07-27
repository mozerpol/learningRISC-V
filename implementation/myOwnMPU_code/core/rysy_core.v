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

  wire [`REG_LEN-1:0]pc;
  wire [`REG_LEN-1:0]inst;
  wire [`ADDR_LEN-1:0]rs1;
  wire [`ADDR_LEN-1:0]rs2;
  wire [`ADDR_LEN-1:0]rd;
  wire [`REG_LEN-1:0]rs1_d;
  wire [`REG_LEN-1:0]rs2_d;
  wire reg_wr;
  wire [`REG_LEN-1:0]rd_d;
  wire [`REG_LEN-1:0]alu_in1;
  wire [`REG_LEN-1:0]alu_in2;
  wire [`REG_LEN-1:0]alu_out;
  wire b;
  wire [`REG_LEN-1:0]imm_I;
  wire [`REG_LEN-1:0]imm_S;
  wire [`REG_LEN-1:0]imm_B;
  wire [`REG_LEN-1:0]imm_U;
  wire [`REG_LEN-1:0]imm_J;
  wire [`REG_LEN-1:0]imm;
  wire [2:0] func3;
  wire [6:0] func7;
  wire [1:0] sel_addr;
  reg [1:0] sel_addr_old;
  wire [`REG_LEN-1:0]rd_mem;

  mem_addr_sel mem_addr_sel_core(
    .pc_sel(pc_sel),
    .mem_sel(mem_sel),
    .pc(pc),
    .alu_out(alu_out)
  );

  inst_mgmt inst_mgmt_core(
    .inst(inst),
    .inst_sel(inst_sel)
  );

  rd_mux rd_mux_core(
    .pc(pc),
    .rd_sel(rd_sel),
    .rd_d(rd_d),
    .alu_out(alu_out),
    .imm(imm),
    .rd_mem(rd_mem)
  );

  alu alu_core(
    .alu_in1(alu_in1),
    .alu_in2(alu_in2),
    .alu_out(alu_out),
    .alu_op(alu_op)
  );

  alu1_mux alu1_mux_core(
    .pc(pc),
    .rs1_d(rs1_d),
    .alu1_sel(alu1_sel),
    .alu_in1(alu_in1)
  );

  alu2_mux alu2_mux_core(
    .rs2_d(rs2_d),
    .alu2_sel(alu2_sel),
    .alu_in2(alu_in2),
    .imm(imm)
  );

  decode decode_core(
    .inst(inst),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .imm_I(imm_I),
    .imm_S(imm_S),
    .imm_B(imm_B),
    .imm_U(imm_U),
    .imm_J(imm_J),
    .func3(func3),
    .func7(func7)
  );

  reg_file reg_file_core(
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .rs1_d(rs1_d),
    .rs2_d(rs2_d),
    .reg_wr(reg_wr),
    .rd_d(rd_d)
  );

  cmp cmp_core(
    .rs1_d(rs1_d),
    .rs2_d(rs2_d),
    .cmp_op(cmp_op),
    .b(b)
  );

  select_wr select_wr_core(
    .rs2_d(rs2_d),
    .sel_addr(sel_addr)
  );

  ctrl ctrl_core(
    .reg_wr(reg_wr),
    .b(b),
    .func3(func3),
    .func7(func7)
  );

  imm_mux imm_mux_core(
    .imm_type(imm_type),
    .imm_I(imm_I),
    .imm_S(imm_S),
    .imm_B(imm_B),
    .imm_U(imm_U),
    .imm_J(imm_J),
    .imm(imm)
  );

  //   select_pkg select_pkg_control(
  //     .sel_type(sel_type)
  //   );

  select_rd select_rd_control(
    .sel_addr_old(sel_addr_old),
    .rd_mem(rd_mem)
  );

  assign sel_addr = addr[1:0];
  always@(posedge clk)
    sel_addr_old <= sel_addr;

endmodule
