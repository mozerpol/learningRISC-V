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
  output wire [4:0]opcode,
  output wire [2:0]func3,
  output wire [6:0]func7
);

  wire sign;
  assign sign = inst[31];
  wire [31:0]imm_I_aux;
  wire [6:0]imm_11_5_S;
  wire [4:0]imm_4_0_S;
  wire imm_11_B;
  wire [5:0]imm_10_5_B;
  wire [3:0]imm_4_1_B;
  wire [31:0]imm_U_aux;
  wire imm_20_J;
  wire [7:0]imm_19_12_J;
  wire imm_11_J;
  wire [9:0]imm_10_1_J;

  R_type R_type_module(
    .instruction(inst),    
    .opcode(opcode),
    .func3(func3),
    .func7(func7),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2)
  );

  I_type I_type_module(
    .instruction(inst),
    .imm(imm_I_aux)
  );

  assign imm_I[10:0] = imm_I_aux[10:0];
  assign imm_I[31:11] = (sign) ? 21'h1fffff : 21'h0;

  S_type S_type_module(
    .instruction(inst),
    .imm_11_5(imm_11_5_S),
    .imm_4_0(imm_4_0_S)
  );

  assign imm_S[10:0] = {imm_11_5_S[5:0], imm_4_0_S};
  assign imm_S[31:11] = (sign) ? 21'h1fffff : 21'h0;

  B_type B_type_module(
    .instruction(inst),
    .imm_11(imm_11_B),
    .imm_10_5(imm_10_5_B),
    .imm_4_1(imm_4_1_B)
  );

  assign imm_B[11:0] = {imm_11_B, imm_10_5_B, imm_4_1_B, 1'b0};
  assign imm_B[31:12] = (sign) ? 20'hfffff : 20'h0;

  U_type U_type_module(
    .instruction(inst),
    .imm(imm_U_aux)
  );

  assign imm_U = {imm_U_aux, 12'h0};

  J_type J_type_module(
    .instruction(inst),
    .imm_20(imm_20_J),
    .imm_19_12(imm_19_12_J),
    .imm_11(imm_11_J),
    .imm_10_1(imm_10_1_J)
  );

  assign imm_J[20:0] = {imm_20_J, imm_19_12_J, imm_11_J, imm_10_1_J, 1'b0};
  assign imm_J[31:21] = (sign) ? 11'h7ff : 11'h0;

endmodule
