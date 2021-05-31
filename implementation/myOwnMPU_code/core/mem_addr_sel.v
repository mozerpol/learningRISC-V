`include "rysy_pkg.vh"
`timescale 100ns / 10ns

// module pc_sel_module(
//   input wire [1:0] pc_sel_in,
//   output wire [1:0] pc_sel_out
// );
//   assign pc_sel_out = pc_sel_in;
// endmodule

// module mem_sel_module(
//   input wire mem_sel_in,
//   input wire mem_sel_out
// );
//   assign mem_sel_out = mem_sel_in;
// endmodule

`define PC_ALU 2'b00
`define PC_P4  2'b01 // Plus
`define PC_M4  2'b10 // Minus
`define PC_OLD 2'b11

module mem_addr_sel(
  input wire clk,
  input wire rst,
  input wire [1:0] pc_sel,
  input wire mem_sel,
  input wire [`REG_LEN-1:0]alu_out,
  output wire [`REG_LEN-1:0]addr,
  output wire [`REG_LEN-1:0]pc
);

  wire [`REG_LEN-1:0] pc_reg;
  assign pc = pc_reg;
  reg [`REG_LEN-1:0] o;
  assign pc_reg = o;

  always@(posedge clk)
    begin
      case(pc_sel)
        `PC_ALU : o <= alu_out;
        `PC_P4  : o <= pc_reg + 4;
        `PC_OLD : o <= pc_reg;
        `PC_M4  : o <= pc_reg - 4;
        default: o <= pc_reg;
      endcase
      if (rst)
        o <= 0;
    end

endmodule
