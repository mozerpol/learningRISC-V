/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

package opcodePkg;

/* Opcodes */

typedef enum bit [4:0] {
	LOAD =		5'b00000,
	LOAD_FP =	5'b00001,
	CUSTOM_0 =	5'b00010,
	MISC_MEM =	5'b00011,
	OP_IMM =	5'b00100,
	AUIPC =		5'b00101,
	OP_IMM_32 =	5'b00110,
	LEN_48_0 =	5'b00111,
	STORE =		5'b01000,
	STORE_FP = 	5'b01001,
	CUSTOM_1 =	5'b01010,
	AMO = 		5'b01011,
	OP =		5'b01100,
	LUI =		5'b01101,
	OP_32 =		5'b01110,
	LEN_64 =	5'b01111,
	MADD =		5'b10000,
	MSUB =		5'b10001,
	NMSUB =		5'b10010,
	NMADD =		5'b10011,
	OP_FP =		5'b10100,
	RESERVED_0 =	5'b10101,
	CUSTOM_2 =	5'b10110,
	LEN_48_1 =	5'b10111,
	BRANCH =	5'b11000,
	JALR =		5'b11001,
	RESERVED_1 =	5'b11010,
	JAL =		5'b11011,
	SYSTEM =	5'b11100,
	RESERVED_2 =	5'b11101,
	CUSTOM_3 =	5'b11110,
	LEN_80 =	5'b11111
} opcode;

/* Functions */

typedef enum bit [2:0] {
	FUNC3_BRANCH_BEQ =	3'b000,
	FUNC3_BRANCH_BNE =	3'b001,
	FUNC3_BRANCH_BLT =	3'b100,
	FUNC3_BRANCH_BGE =	3'b101,
	FUNC3_BRANCH_BLTU =	3'b110,
	FUNC3_BRANCH_BGEU =	3'b111
} FUNC3_BRANCH;

typedef enum bit [2:0] {
	FUNC3_SB =		3'b000,
	FUNC3_SH =		3'b001,
	FUNC3_SW =		3'b010,
	FUNC3_SBU =		3'b100,
	FUNC3_SHU =		3'b101
} FUNC3_LOAD_STORE;

typedef enum bit [2:0] {
	FUNC3_ADD_SUB =		3'b000,
	FUNC3_SLT =		3'b010,
	FUNC3_SLTU =		3'b011,
	FUNC3_XOR =		3'b100,
	FUNC3_OR =		3'b110,
	FUNC3_AND =		3'b111,
	FUNC3_SLL =		3'b001,
	FUNC3_SR =		3'b101
} FUNC3_OP_IMM;

typedef enum bit [6:0] {
	FUNC7_SR_SRL =	7'b0000000,
	FUNC7_SR_SRA =	7'b0100000
} FUNC7_SR;

typedef enum bit [6:0] {
	FUNC7_ADD_SUB_ADD = 	7'b0000000,
	FUNC7_ADD_SUB_SUB =	7'b0100000
} FUNC7_OP_ADD_SUB;

typedef enum bit [2:0] {
	FUNC3_MISC_MEM_FENCE =	3'b000
} FUNC3_MISC_MEM;

typedef enum bit [24:0] {
	FUNC_SYSTEM_ECALL = 25'b0,
	FUNC_SYSTEM_EBREAK = 25'h2000
} FUNC25_SYSTEM;

endpackage : opcodePkg
