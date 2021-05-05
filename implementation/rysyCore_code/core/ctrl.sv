/*-
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright (c) 2019 Rafal Kozik
 * All rights reserved.
 */

`default_nettype none

module ctrl(
	input wire clk,
	input wire rst,
	input opcodePkg::opcode opcode,
	input wire [2:0]func3,
	input wire [6:0]func7,
	input wire b,
	output instMgmtPkg::inst_sel inst_sel,
	output immPkg::imm_type imm_type,
	output logic reg_wr,
	output aluPkg::alu_op alu_op,
	output cmpPkg::cmp_op cmp_op,
	output pcPkg::pc_sel pc_sel,
	output pcPkg::mem_sel mem_sel,
	output rdPkg::rd_sel rd_sel,
	output alu1Pkg::alu1_sel alu1_sel,
	output alu2Pkg::alu2_sel alu2_sel,
	output selectPkg::sel_type sel_type,
	output logic we
);

logic next_nop;
logic load_phase;

always_comb
	case (opcode)
		opcodePkg::OP_IMM, opcodePkg::OP:
			case(func3)
				opcodePkg::FUNC3_ADD_SUB:
					if ((opcode == opcodePkg::OP) &&
					    (func7 == opcodePkg::FUNC7_ADD_SUB_SUB))
						alu_op = aluPkg::SUB;
					else
						alu_op = aluPkg::ADD;
				opcodePkg::FUNC3_SLT: alu_op = aluPkg::SLT;
				opcodePkg::FUNC3_SLTU: alu_op = aluPkg::SLTU;
				opcodePkg::FUNC3_XOR: alu_op = aluPkg::XOR;
				opcodePkg::FUNC3_OR: alu_op = aluPkg::OR;
				opcodePkg::FUNC3_AND: alu_op = aluPkg::AND;
				opcodePkg::FUNC3_SLL: alu_op = aluPkg::SLL;
				opcodePkg::FUNC3_SR:
					case(func7)
						opcodePkg::FUNC7_SR_SRL:
							alu_op = aluPkg::SRL;
						opcodePkg::FUNC7_SR_SRA:
							alu_op = aluPkg::SRA;
						default:
							alu_op = aluPkg::ADD;
					endcase
				default: alu_op = aluPkg::ADD;
			endcase
		opcodePkg::LOAD,
		opcodePkg::STORE,
		opcodePkg::BRANCH,
		opcodePkg::JAL,
		opcodePkg::JALR: alu_op = aluPkg::ADD;
		default: alu_op = aluPkg::ADD;
	endcase

always_comb
	case (opcode)
		opcodePkg::OP_IMM: imm_type = immPkg::IMM_I;
		opcodePkg::LUI: imm_type = immPkg::IMM_U;
		opcodePkg::JAL: imm_type = immPkg::IMM_J;
		opcodePkg::JALR: imm_type = immPkg::IMM_I;
		opcodePkg::BRANCH: imm_type = immPkg::IMM_B;
		opcodePkg::LOAD: imm_type = immPkg::IMM_I;
		opcodePkg::STORE: imm_type = immPkg::IMM_S;
		default: imm_type = immPkg::IMM_DEFAULT;
	endcase

always_comb
	case (opcode)
		opcodePkg::BRANCH,
		opcodePkg::JAL: alu1_sel = alu1Pkg::ALU1_PC;
		default: alu1_sel = alu1Pkg::ALU1_RS;
	endcase

always_comb
	case (opcode)
		opcodePkg::LOAD,
		opcodePkg::STORE,
		opcodePkg::BRANCH,
		opcodePkg::JALR,
		opcodePkg::JAL,
		opcodePkg::OP_IMM: alu2_sel = alu2Pkg::ALU2_IMM;
		opcodePkg::OP: alu2_sel = alu2Pkg::ALU2_RS;
		default: alu2_sel = alu2Pkg::ALU2_IMM;
	endcase

always_comb
	case (opcode)
		opcodePkg::JALR,
		opcodePkg::JAL,
		opcodePkg::OP_IMM,
		opcodePkg::LUI,
		opcodePkg::OP: reg_wr = 1'b1;
		opcodePkg::LOAD: reg_wr = load_phase;
		default: reg_wr = 1'b0;
	endcase

always_comb
	case (opcode)
		opcodePkg::OP_IMM,
		opcodePkg::OP: rd_sel = rdPkg::RD_ALU;
		opcodePkg::LUI: rd_sel = rdPkg::RD_IMM;
		opcodePkg::JALR,
		opcodePkg::JAL: rd_sel = rdPkg::RD_PCP4;
		opcodePkg::LOAD: rd_sel = rdPkg::RD_MEM;
		default: rd_sel = rdPkg::RD_ALU;
	endcase

always_comb
	case (opcode)
		opcodePkg::JALR,
		opcodePkg::JAL: pc_sel = pcPkg::PC_ALU;
		opcodePkg::BRANCH: pc_sel = b ? pcPkg::PC_ALU : pcPkg::PC_P4;
		opcodePkg::STORE: pc_sel = pcPkg::PC_OLD;
		opcodePkg::LOAD:
			case (load_phase)
				1'd0: pc_sel = pcPkg::PC_M4;
				1'd1: pc_sel = pcPkg::PC_P4;
				default: pc_sel = pcPkg::PC_OLD;
			endcase
		default: pc_sel = pcPkg::PC_P4;
	endcase

always_ff @(posedge clk) begin
	if (rst)
		next_nop = 1'b1; // Prevent first inst of being processed twice.
	else if ((opcode == opcodePkg::JAL) || (opcode == opcodePkg::JALR) ||
		 ((opcode == opcodePkg::BRANCH) && b) ||
	 	 (opcode == opcodePkg::STORE))
		next_nop = 1'b1;
	else
		next_nop = 1'b0;
end

always_comb
	if (next_nop)
		inst_sel = instMgmtPkg::INST_NOP;
	else
		case (opcode)
			opcodePkg::JALR,
			opcodePkg::JAL: inst_sel = instMgmtPkg::INST_NOP;
			opcodePkg::BRANCH: inst_sel =
			    b ? instMgmtPkg::INST_NOP : instMgmtPkg::INST_MEM;
			opcodePkg::LOAD:
				case (load_phase)
					1'd1: inst_sel = instMgmtPkg::INST_NOP;
					default: inst_sel = instMgmtPkg::INST_OLD;
				endcase
			default: inst_sel = instMgmtPkg::INST_MEM;
		endcase

always_comb
	case(func3)
		opcodePkg::FUNC3_BRANCH_BEQ: cmp_op = cmpPkg::EQ;
		opcodePkg::FUNC3_BRANCH_BNE: cmp_op = cmpPkg::NE;
		opcodePkg::FUNC3_BRANCH_BLT: cmp_op = cmpPkg::LT;
		opcodePkg::FUNC3_BRANCH_BGE: cmp_op = cmpPkg::GE;
		opcodePkg::FUNC3_BRANCH_BLTU: cmp_op = cmpPkg::LTU;
		opcodePkg::FUNC3_BRANCH_BGEU: cmp_op = cmpPkg::GEU;
		default: cmp_op = cmpPkg::EQ;
	endcase

always_comb
	case (opcode)
		opcodePkg::STORE: mem_sel = pcPkg::MEM_ALU;
		opcodePkg::LOAD:
			case (load_phase)
				1'd0: mem_sel = pcPkg::MEM_ALU;
				default: mem_sel = pcPkg::MEM_PC;
			endcase
		default: mem_sel = pcPkg::MEM_PC;
	endcase

always_comb
	case (opcode)
		opcodePkg::STORE: we = 1'b1;
		default: we = 1'b0;
	endcase

always_comb
	case (func3)
		opcodePkg::FUNC3_SB: sel_type = selectPkg::SB;
		opcodePkg::FUNC3_SH: sel_type = selectPkg::SH;
		opcodePkg::FUNC3_SW: sel_type = selectPkg::SW;
		opcodePkg::FUNC3_SBU: sel_type = selectPkg::SBU;
		opcodePkg::FUNC3_SHU: sel_type = selectPkg::SHU;
		default: sel_type = selectPkg::SW;
	endcase

always_ff @(posedge clk) begin
	if (opcode == opcodePkg::LOAD)
		load_phase = ~load_phase;
	if (rst)
		load_phase <= '0;
end

endmodule

`default_nettype wire
