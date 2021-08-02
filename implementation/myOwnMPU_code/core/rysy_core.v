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

  wire [1:0] pc_sel;
  wire mem_sel;
  mem_addr_sel mem_addr_sel_core(
    .pc_sel(pc_sel),
    .mem_sel(mem_sel),
    .pc(pc),
    .alu_out(alu_out),
    .clk(clk),
    .rst(rst),
    .addr(addr)
  );

  wire [1:0] rd_sel;
  rd_mux rd_mux_core(
    .pc(pc),
    .rd_sel(rd_sel),
    .rd_d(rd_d),
    .alu_out(alu_out),
    .imm(imm),
    .rd_mem(rd_mem),
    .clk(clk)
  );






  ctrl ctrl_core(
    .clk(clk),
    .rst(rst),
    .opcode(opcode),
    .func3(func3),
    .func7(func7),
    .b(b),
    .reg_wr(reg_wr),
    .we(we),
    .pc_sel(pc_sel),
    .mem_sel(mem_sel),
    .imm_type(imm_type),
    .inst_sel(inst_sel),
    .alu1_sel(alu1_sel),
    .alu2_sel(alu2_sel),
    .rd_sel(rd_sel),
    .cmp_op(cmp_op),   
    .sel_type(sel_type), 
    .alu_op(alu_op)
  );

endmodule
