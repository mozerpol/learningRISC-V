`include "rysy_pkg.vh"
`timescale 100ns / 10ns

`define PC_ALU 2'b00
`define PC_P4  2'b01 // Plus
`define PC_M4  2'b10 // Minus
`define PC_OLD 2'b11
`define MEM_PC 1'b0
`define MEM_ALU 1'b1

module mem_addr_sel(
  input wire clk,
  input wire rst,
  input wire [1:0] pc_sel, 			// mux for PC
  input wire mem_sel, 				// mux, instruction from PC or ALU?
  input wire [`REG_LEN-1:0]alu_out, // value to PC from ALU?
  output wire [`REG_LEN-1:0]addr, 	// for ADDR module
  output wire [`REG_LEN-1:0]pc 		// for PC module
);

  reg [`REG_LEN-1:0] pc_reg;
  assign pc = pc_reg;

  always@(posedge clk)
    begin
      case(pc_sel)
        `PC_ALU : pc_reg <= alu_out; 	// value to PC from alu
        `PC_P4  : pc_reg <= pc_reg + 4; // Increment actual value in PC
        `PC_M4  : pc_reg <= pc_reg - 4;
        `PC_OLD : pc_reg <= pc_reg; 	// Do nothing
        default: pc_reg <= pc_reg;
      endcase
      if (rst)
        pc_reg <= 0;
    end

  reg [`REG_LEN-1:0] addr_reg;
  assign addr = addr_reg;

  always@(*)
    case(mem_sel)
      `MEM_PC  : addr_reg = pc_reg;
      `MEM_ALU : addr_reg = alu_out;
    endcase

endmodule
