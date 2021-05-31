`include "rysy_pkg.vh"
`timescale 100ns / 10ns

`define	INST_OLD 2'b00
`define INST_NOP 2'b01
`define INST_MEM 2'b10

module inst_mgmt(
  input wire clk,
  input wire rst,
  input wire [1:0] inst_sel,
  input wire [`REG_LEN-1:0] rdata,
  output wire [`REG_LEN-1:0] inst
);

  parameter NOP = 32'h00000013;
  reg [`REG_LEN-1:0] o;
  assign inst = o;

  always @(posedge clk) begin
    case(inst_sel)
      `INST_OLD : o <= inst; // Previous instruction on output.
      `INST_NOP : o <= NOP; // NOP on output.
      `INST_MEM : o <= rdata; // Instruction from RDATA on output. Just transfer in to out.
      default : o <= NOP; // Tkanks to this line, when we run the processor on our
      // output, we get NOP.
    endcase
    if(rst) o <= NOP;
  end

endmodule
