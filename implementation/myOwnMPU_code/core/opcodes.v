`timescale 100ns / 10ns

module opcode(
  input wire [4:0] opcode_in,
  output wire [4:0] opcode_out
);

  localparam LOAD =		5'b00000;
  localparam LOAD_FP =	5'b00001;
  localparam CUSTOM_0 =	5'b00010;
  localparam MISC_MEM =	5'b00011;
  localparam OP_IMM =	5'b00100;
  localparam AUIPC =	5'b00101;
  localparam OP_IMM_32 = 5'b00110;
  localparam LEN_48_0 =	5'b00111;
  localparam STORE =	5'b01000;
  localparam STORE_FP =	5'b01001;
  localparam CUSTOM_1 =	5'b01010;
  localparam AMO = 		5'b01011;
  localparam OP =		5'b01100;
  localparam LUI =		5'b01101;
  localparam OP_32 =	5'b01110;
  localparam LEN_64 = 	5'b01111;
  localparam MADD =		5'b10000;
  localparam MSUB =		5'b10001;
  localparam NMSUB =	5'b10010;
  localparam NMADD =	5'b10011;
  localparam OP_FP =	5'b10100;
  localparam RESERVED_0 = 5'b10101;
  localparam CUSTOM_2 =	5'b10110;
  localparam LEN_48_1 =	5'b10111;
  localparam BRANCH =	5'b11000;
  localparam JALR =		5'b11001;
  localparam RESERVED_1 = 5'b11010;
  localparam JAL =		5'b11011;
  localparam SYSTEM =	5'b11100;
  localparam RESERVED_2 = 5'b11101;
  localparam CUSTOM_3 =	5'b11110;
  localparam LEN_80 =	5'b11111;

  reg [4:0] o;
  assign opcode_out = o;

  always@(opcode_in)
    begin
      case(opcode_in)
        5'b00000 : o = LOAD;
        5'b00001 : o = LOAD_FP;
        5'b00010 : o = CUSTOM_0;
        5'b00011 : o = MISC_MEM;
        5'b00100 : o = OP_IMM;
        5'b00101 : o = AUIPC;
        5'b00110 : o = OP_IMM_32;
        5'b00111 : o = LEN_48_0;
        5'b01000 : o = STORE;
        5'b01001 : o = STORE_FP;
        5'b01010 : o = CUSTOM_1;
        5'b01011 : o = AMO;
        5'b01100 : o = OP;
        5'b01101 : o = LUI;
        5'b01110 : o = OP_32;
        5'b01111 : o = LEN_64;
        5'b10000 : o = MADD;
        5'b10001 : o = MSUB;
        5'b10010 : o = NMSUB;
        5'b10011 : o = NMADD;
        5'b10100 : o = OP_FP;
        5'b10101 : o = RESERVED_0;
        5'b10110 : o = CUSTOM_2;
        5'b10111 : o = LEN_48_1;
        5'b11000 : o = BRANCH;
        5'b11001 : o = JALR;
        5'b11010 : o = RESERVED_1;
        5'b11011 : o = JAL;
        5'b11100 : o = SYSTEM;
        5'b11101 : o = RESERVED_2;
        5'b11110 : o = CUSTOM_3;
        5'b11111 : o = LEN_80;
      endcase
    end

endmodule


