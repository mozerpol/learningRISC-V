`include "rysy_pkg.v"

`define RD_IMM 	2'b00
`define RD_PCP4 2'b01
`define RD_ALU 	2'b10
`define RD_MEM 	2'b11

module rd_mux(
  input wire [`REG_LEN-1:0] imm,
  input wire [`REG_LEN-1:0] pc,
  input wire [`REG_LEN-1:0] alu_out,
  input wire [`REG_LEN-1:0] rd_mem,
  input wire clk,
  input wire [1:0] rd_sel,
  output wire [`REG_LEN-1:0] rd_d
);

  reg [`REG_LEN-1:0] o;
  assign rd_d = o;
  reg [`REG_LEN-1:0] old_pc;

  always@(posedge clk) old_pc <= pc;

  always@(*)
    case(rd_sel)
      `RD_IMM : o = imm;
      `RD_PCP4: o = old_pc;
      `RD_ALU : o = alu_out;
      `RD_MEM : o = rd_mem;
    endcase
endmodule
