`timescale 100ns / 10ns

module R_type(
  input wire [31:0]instruction,
  output wire [6:0]func7,
  output wire [4:0]rs2,
  output wire [4:0]rs1,
  output wire [2:0]func3,
  output wire [4:0]rd,
  output wire [4:0]opcode,
  output wire [1:0]low_op
);

  assign func7 = instruction[31:25];
  assign rs2 = instruction[24:20];
  assign rs1 = instruction[19:15];
  assign func3 = instruction[14:12];
  assign rd = instruction[11:7];
  // assign opcode = instruction[6:2];
  assign low_op = instruction[1:0];

  reg [4:0]opcode_reg;
  assign opcode = opcode_reg;

  // This part is necessary, because we mnust set up appropriate opcode
  // in case of hi-z state for [31:0]instruction. I mean, if our inoput is
  // "strange" like HiZ od undefined state then assign to opcode 0.
  always@(instruction[6:2])
    begin
      if((instruction[4] == 0) || (instruction[4] == 1))
        opcode_reg = instruction[6:2];
      else
        opcode_reg = {5{1'b0}};
    end

endmodule 

module I_type(
  input wire [31:0] instruction,
  output wire [11:0]imm,
  output wire [4:0]rs1,
  output wire [2:0]func3,
  output wire [4:0]rd
);

  assign imm = instruction[31:20];
  assign rs1 = instruction[19:15];
  assign func3 = instruction[14:12];
  assign rd = instruction[11:7];
endmodule 

module S_type(
  input wire [31:0] instruction,
  output wire [6:0]imm_11_5,
  output wire [4:0]rs2,
  output wire [4:0]rs1,
  output wire [2:0]func3,
  output wire [4:0]imm_4_0
);

  assign imm_11_5 = instruction[31:25];
  assign rs2 = instruction[24:20];
  assign rs1 = instruction[19:15];
  assign func3 = instruction[14:12];
  assign imm_4_0 = instruction[11:7];
endmodule 

module B_type(
  input wire [31:0] instruction,
  output wire imm_12,
  output wire [5:0]imm_10_5,
  output wire [4:0]rs2,
  output wire [4:0]rs1,
  output wire [2:0]func3,
  output wire [3:0]imm_4_1,
  output wire imm_11
);

  assign imm_12 = instruction[31:31];
  assign imm_10_5 = instruction[30:25];
  assign rs2 = instruction[24:20];
  assign rs1 = instruction[19:15];
  assign func3 = instruction[14:12];
  assign imm_4_1 = instruction[11:8];
  assign imm_11 = instruction[7:7];
endmodule 

module U_type(
  input wire [31:0] instruction,
  output wire [19:0]imm,
  output wire [4:0]rd
);

  assign imm = instruction[31:12];
  assign rd = instruction[11:7];
endmodule 

module J_type(
  input wire [31:0] instruction,
  output wire imm_20,
  output wire [9:0]imm_10_1,
  output wire imm_11,
  output wire [7:0]imm_19_12,
  output wire [4:0]rd
);

  assign imm_20 = instruction[31:31];
  assign imm_10_1 = instruction[30:21];
  assign imm_11 = instruction[20:20];
  assign imm_19_12 = instruction[19:12];
  assign rd = instruction[11:7];
endmodule
