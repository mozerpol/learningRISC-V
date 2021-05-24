`timescale 100ns / 10ns

module R_type(
  input wire [31:0] instruction,
  output wire [6:0]func7,
  output wire [4:0]rs2,
  output wire [4:0]rs1,
  output wire [2:0]func3,
  output wire [4:0]rd,
  //output opcode,
  output wire [6:0]low_op
);

  assign func7 = instruction[31:25];
  assign rs2 = instruction[24:20];
  assign rs1 = instruction[19:15];
  assign func3 = instruction[14:12];
  assign rd = instruction[11:7];
  assign low_op = instruction[6:0];
endmodule 

module I_type(
  input wire [31:0] instruction,
  output wire [11:0]imm,
  output wire [4:0]rs1,
  output wire [2:0]func3,
  output wire [4:0]rd,
 // output wire opcode,
  output wire [6:0]low_op
);

  assign imm = instruction[31:20];
  assign rs1 = instruction[19:15];
  assign func3 = instruction[14:12];
  assign rd = instruction[11:7];
  assign low_op = instruction[6:0];
endmodule 

