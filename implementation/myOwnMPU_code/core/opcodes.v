//''''''''''''//
//   opcode   //
//,,,,,,,,,,,,//
`define	LOAD =		5'b00000
`define	LOAD_FP =	5'b00001
`define	CUSTOM_0 =	5'b00010
`define	MISC_MEM =	5'b00011
`define OP_IMM =	5'b00100
`define AUIPC =		5'b00101
`define OP_IMM_32 =	5'b00110
`define LEN_48_0 =	5'b00111
`define STORE =		5'b01000
`define STORE_FP = 	5'b01001
`define CUSTOM_1 =	5'b01010
`define AMO = 		5'b01011
`define OP =		5'b01100
`define LUI =		5'b01101
`define OP_32 =		5'b01110
`define LEN_64 =	5'b01111
`define MADD =		5'b10000
`define MSUB =		5'b10001
`define NMSUB =		5'b10010
`define NMADD =		5'b10011
`define OP_FP =		5'b10100
`define RESERVED_0 = 5'b10101
`define CUSTOM_2 =	5'b10110
`define LEN_48_1 =	5'b10111
`define BRANCH =	5'b11000
`define JALR =		5'b11001
`define RESERVED_1 = 5'b11010
`define JAL =		5'b11011
`define SYSTEM =	5'b11100
`define RESERVED_2 = 5'b11101
`define CUSTOM_3 =	5'b11110
`define LEN_80 =	5'b11111

//''''''''''''''''''//
//   FUNC3_BRANCH   //
//,,,,,,,,,,,,,,,,,,//
`define FUNC3_BRANCH_BEQ =	3'b000
`define FUNC3_BRANCH_BNE =	3'b001
`define FUNC3_BRANCH_BLT =	3'b100
`define FUNC3_BRANCH_BGE =	3'b101
`define FUNC3_BRANCH_BLTU =	3'b110
`define FUNC3_BRANCH_BGEU =	3'b111

//''''''''''''''''''''''//
//   FUNC3_LOAD_STORE   //
//,,,,,,,,,,,,,,,,,,,,,,//
`define FUNC3_SB =	3'b000
`define FUNC3_SH =	3'b001
`define FUNC3_SW =	3'b010
`define FUNC3_SBU =	3'b100
`define FUNC3_SHU =	3'b101

//''''''''''''''''''//
//   FUNC3_OP_IMM   //
//,,,,,,,,,,,,,,,,,,//
`define FUNC3_ADD_SUB =	3'b000
`define FUNC3_SLT =		3'b010
`define FUNC3_SLTU =	3'b011
`define FUNC3_XOR =		3'b100
`define FUNC3_OR =		3'b110
`define FUNC3_AND =		3'b111
`define FUNC3_SLL =		3'b001
`define FUNC3_SR =		3'b101

//''''''''''''''//
//   FUNC7_SR   //
//,,,,,,,,,,,,,,//
`define FUNC7_SR_SRL =	7'b0000000
`define FUNC7_SR_SRA =	7'b0100000

//''''''''''''''''''''''//
//   FUNC7_OP_ADD_SUB   //
//,,,,,,,,,,,,,,,,,,,,,,//
`define FUNC7_ADD_SUB_ADD = 7'b0000000
`define FUNC7_ADD_SUB_SUB =	7'b0100000 

//''''''''''''''''''''//
//   FUNC3_MISC_MEM   //
//,,,,,,,,,,,,,,,,,,,,//
`define FUNC3_MISC_MEM_FENCE = 3'b000

//'''''''''''''''''''//
//   FUNC25_SYSTEM   //
//,,,,,,,,,,,,,,,,,,,//
`define FUNC_SYSTEM_ECALL =	25'b0
`define FUNC_SYSTEM_EBREAK = 25'h2000
