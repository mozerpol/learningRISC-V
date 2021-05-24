`include "instructions.v"
`timescale 100ns / 10ns

module decode(
  input wire [31:0]inst,
  output wire [4:0]rd,
  output wire [4:0]rs1,
  output wire [4:0]rs2,
  output wire [31:0]imm_I,
  output wire [31:0]imm_S,
  output wire [31:0]imm_B,
  output wire [31:0]imm_U,
  output wire [31:0]imm_J,
  output wire opcode,
  output wire [2:0]func3,
  output wire [6:0]func7
);
	
  R_type R_type_module(
    .instruction(inst)
  );

endmodule
