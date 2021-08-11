/*
      By Mozerpol
*/

`timescale 100ns / 10ns

`include "rysy_pkg.vh"
`include "opcodes.vh"
`include "imm_mux.vh"
`include "alu.vh"
`include "alu1_mux.vh"
`include "alu2_mux.vh"
`include "cmp.vh"
`include "inst_mgmt.vh"
`include "mem_addr_sel.vh"
`include "rd_mux.vh"
`include "select_wr.vh"
`include "select_rd.vh"
`include "select_pkg.vh"

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
  wire [4:0] opcode;
  wire [2:0]imm_type;
  wire [1:0] inst_sel;
  wire [2:0] cmp_op;
  wire [2:0] sel_type;
  wire [3:0] alu_op;
  wire alu1_sel;
  wire alu2_sel;
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

  inst_mgmt inst_mgmt_core(
    .clk(clk),
    .rst(rst),
    .inst_sel(inst_sel),
    .rdata(rdata),
    .inst(inst)
  );

  decode decode_core(
    .inst(inst),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .imm_I(imm_I),
    .imm_S(imm_S),
    .imm_B(imm_B),
    .imm_U(imm_U),
    .imm_J(imm_J),
    .opcode(opcode),
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

  select_rd select_rd_core(
    .sel_addr_old(sel_addr_old),
    .rd_mem(rd_mem),
    .rdata(rdata),
    .sel_type(sel_type)
  );

  reg_file reg_file_core(
    .rs1_d(rs1_d),
    .rs2_d(rs2_d),
    .reg_wr(reg_wr),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .rd_d(rd_d),
    .clk(clk)
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

  alu1_mux alu1_mux_core(
    .rs1_d(rs1_d),
    .pc(pc),
    .alu1_sel(alu1_sel),
    .clk(clk),
    .alu_in1(alu_in1)
  );

  alu2_mux alu2_mux_core(
    .rs2_d(rs2_d),
    .imm(imm),
    .alu2_sel(alu2_sel),
    .alu_in2(alu_in2)
  );

  alu alu_core(
    .alu_op(alu_op),
    .alu_in1(alu_in1),
    .alu_in2(alu_in2),
    .alu_out(alu_out)
  );

  cmp cmp_core(
    .rs1_d(rs1_d),
    .rs2_d(rs2_d),
    .cmp_op(cmp_op),
    .b(b)
  );

  select_wr select_wr_core(
    .rs2_d(rs2_d),
    .sel_type(sel_type),
    .sel_addr(sel_addr),
    .be(be), 
    .wdata(wdata)
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

  assign sel_addr = addr[1:0];
  always@(posedge clk)
    sel_addr_old <= sel_addr;

endmodule
