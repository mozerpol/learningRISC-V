/*
	Made by Mozerpol
    This file contains code which is responsible for decode part. We have one input, this input
    comes from INST part, which gives us instruction (32 bits). We have six outputs which for
    every instruction are the same and five outputs which depends from instruction. Ok, so...
    Outputs: rd, rs1, rs2, opcode, func3, func7 are placed in each instruction at the same bits.
    If you don't understand, just take look at base instruction format. In the picture we can
    notice that some parts like rs1 or opcode of instruction are always at the same place. 
    Thanks to this it's not necessary take from each instruction opcode. We know that opcode
    is on the first six bits, so we can just take from one instruction these six bits.    
*/

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

  wire sign; // We're checking the sign for J-type instruction
  assign sign = inst[31]; // The sign is in the 31st position in the instruction format
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

  /*
  	As I wrote up, opcode, func3, func7, rd, rs1 and rs2 are in the same position in mostly
    instructions, so we can just only once assign these parts of instruction. It's not
    necessary for each instruction.
  */
  R_type R_type_module( 
    .instruction(inst),    
    .opcode(opcode),
    .func3(func3),
    .func7(func7),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2)
  );

  /*
  	Just take a look at instruction format. Only one difference in I-type and the rest of 
    the instructions. This difference is imm value which is placed among 20 and 31 bit.
  */
  I_type I_type_module(
    .instruction(inst),
    .imm(imm_I_aux)
  );

  assign imm_I[10:0] = imm_I_aux[10:0];
  assign imm_I[31:11] = (sign) ? 21'h1fffff : 21'h0; // 21'h1fffff is equal
  // 111111111111111111111 in bin (21 bits). 

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
