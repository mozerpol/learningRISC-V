/*
	By Mozerpol
*/

`timescale 100ns / 10ns

`define OP		5'b01100 // from opcodes.sv
`define STORE	5'b01000
`define JALR	5'b11001
`define	OP_IMM	5'b00100
`define LUI		5'b01101
`define JAL		5'b11011
`define BRANCH	5'b11000
`define LOAD 5'b00000
`define FUNC3_ADD_SUB	3'b000
`define FUNC3_SLT		3'b010
`define FUNC3_XOR		3'b100
`define FUNC3_SLL		3'b001
`define FUNC3_SR		3'b101
`define FUNC3_BRANCH_BEQ	3'b000
`define FUNC3_BRANCH_BGE 	3'b101
`define FUNC3_BRANCH_BLTU	3'b110
`define FUNC3_SH		3'b001
`define FUNC3_SBU		3'b100
`define FUNC3_SHU		3'b101
`define FUNC7_SR_SRL		7'b0000000
`define FUNC7_SR_SRA		7'b0100000
`define FUNC7_ADD_SUB_SUB	7'b0100000
`define FUNC7_ADD_SUB_ADD	7'b0000000

module ctrl_tb;
  reg clk_tb = 1'b1;
  reg rst_tb;
  reg [4:0] opcode_tb;
  reg [2:0] func3_tb;
  reg [6:0] func7_tb;
  reg b_tb;

  ctrl dut(
    .clk(clk_tb),
    .rst(rst_tb),
    .opcode(opcode_tb),
    .func3(func3_tb),
    .func7(func7_tb),
    .b(b_tb)
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for imm_mux
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb = `LUI;		#5;	// imm_type should return IMM_U 3'b001
    opcode_tb = `OP_IMM; 	#5;	// imm_type should return IMM_I 3'b100
    opcode_tb = `STORE; 	#5;	// imm_type should return IMM_S 3'b011

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for alu1_nux
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb = `JAL; 		#5;	// alu1_sel should return 1
    opcode_tb = `LOAD;	 	#5; // alu1_sel should return 0

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for alu2_mux
    //		We have only one case when alu2_sel return 0, it's
    //		for opcode_tb = `OP
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb = `OP;		#5;	// alu2_sel should return 0
    opcode_tb = 5'b10101;	#5;	// default value, alu2_sel should return 1
    opcode_tb = `OP_IMM;	#5;	// alu2_sel should return 1
    opcode_tb = `OP;		#5;	// alu2_sel should return 0

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for rd_mux
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb = `OP_IMM;	#5;	// rd_sel should return 2'b10
    opcode_tb = `JAL;		#5;	// rd_sel should return 2'b01
    opcode_tb = `LOAD;		#5;	// rd_sel should return 2'b11

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for reg_wr from reg_file module
    //		Also this module consists "load_phase", which control
    //		order of execution of instructions (by modify value of program
    //		counter and inst_mgm module).
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb = `STORE;		#5;	// reg_wr should return 0
    opcode_tb = `OP_IMM;	#5;	// reg_wr should return 1
    opcode_tb = `STORE;		#5;	// reg_wr should return 0
    opcode_tb = `LOAD;		#5;	// reg_wr should return an
    // unknown logic value (load_phase)
    opcode_tb = `OP_IMM;	#5;	// reg_wr should return 1

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for mem_addr_sel pc_sel part
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb = `JALR;		#5;	// pc_sel should return 0, JALR opcode = 5'b11001
    opcode_tb = `BRANCH;		// BRANCH opcode = 5'b11000
    b_tb	  =	0;			#5; // pc_sel should return 01
    b_tb	  =	1;			#5; // pc_sel should return 0
    opcode_tb = `LOAD;

    rst_tb 	  = 1'b1;		#10;// load_phase = 0, pc_sel should return 10,
    // delay set at 10, because load_phase needs two clock cycles to change
    // their state
    rst_tb 	  = 1'b0;		#10;// load_phase = 1, pc_sel should return 01

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for cmp
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    func3_tb = `FUNC3_BRANCH_BLTU; 	#5;		// cmp_op should return 3'b100
    func3_tb = `FUNC3_BRANCH_BGE; 	#5;		// cmp_op should return 3'b011
    func3_tb = `FUNC3_BRANCH_BEQ; 	#5;		// cmp_op should return 3'b000

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for mem_addr_sel mem_sel part
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb = `STORE;		#5;	// mem_sel should return 01
    rst_tb 	  = 1'b0;
    opcode_tb = `LOAD;		#10;// mem_sel should return 0, load_phase = 1
    rst_tb 	  = 1'b1;
    opcode_tb = `LOAD;		#10;// mem_sel should return 01, load_phase = 0
    opcode_tb = 5'b11011;	#5;	// mem_sel should return default value, it means
    // mem_sel should return 0, load_phase = 0

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for eleventh always_comb, which control select_pkg
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    func3_tb = `FUNC3_SHU;	#5;	// sel_type should return 100
    func3_tb = `FUNC3_SBU;	#5;	// sel_type should return 011
    func3_tb = `FUNC3_SH;	#5	// sel_type should return 01

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for inst_mgm
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb = `STORE; 	#10;// inst_sel should return 01, next_nop = 1
    rst_tb 	  = 1'b0;
    opcode_tb = `BRANCH;
    b_tb 	  = 0;			#10;// inst_sel should return 10, next_nop = 0
    opcode_tb = `LOAD;		
    rst_tb 	  = 1'b0;		#50;// inst_sel at the beginning should return 
    // 0 and in the next rising clk edge should change their state on 1. The
    // same situation is with inst_sel. At the beginning it should return 0,
    // but in the next rising clk edge should return 1. The guity for this 
    // situation is "load_phase = ~load_phase;" line.
    rst_tb 	  = 1'b1;		#20;// inst_sel should return 01, next_nop = 1

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test control ALU
    //  
    //	always_comb hierarchy:
    //	
    //	opcode:
    //		1. OP_IMM or OP
    //			1.1. func3
    //				1.1.1. ADD or SUB - func3 is the same
    //					1.1.1.1. func7 == 0100000 -> SUB
    //					1.1.1.2  else -> ADD
    //				1.1.2. SLT
    //					.
    //					.		Only one difference: func3
    //					.
    //				1.1.6. SLL 
    //				1.1.7. SR func3
    //					1.1.7.1 func7 = 0100000 -> SRL
    //					1.1.7.2 func7 = 0000000 -> SRA
    //		2. opcode = LOAD -> alu_op = ADD
    //		3. opcode = STORE -> alu_op = ADD
    //					.
    //					.
    //					.
    //		5. opcode = JALR -> alu_op = ADD
    //
    //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    // 1. OP
    opcode_tb = `OP;	#5;	// but can be also OP_IMM
    // 1.1 func3
    // 1.1.1 func3 for ADD or SUB
    func3_tb = `FUNC3_ADD_SUB;
    // 1.1.1.1 func7 == 0100000 -> SUB
    func7_tb = `FUNC7_ADD_SUB_SUB;	#5;	// alu_op should return 1
    // 1.1.1.2 func7 == 0000000 -> ADD
    func7_tb = `FUNC7_ADD_SUB_ADD;	#5; // alu_op should return 0
    // 1.1.2. SLT
    func3_tb = `FUNC3_SLT; #5; // alu_op should return 1000
    // 1.1.3. XOR
    func3_tb = `FUNC3_XOR; #5; // alu_op should return 0010
    // 1.1.4. SLL
    func3_tb = `FUNC3_SLL; #5; // alu_op should return 0101
    // 1.1.7. SR
    func3_tb = `FUNC3_SR;
    // 1.1.7.2 func7 = 0000000 -> SRL
    func7_tb = `FUNC7_SR_SRL; 		#5; // alu_op should return 0110
    // 1.1.7.1 func7 = 0100000 -> SRA
    func7_tb = `FUNC7_SR_SRA; 		#5; // alu_op should return 0111
    // 2. opcode = STORE -> alu_op = ADD (4'b0000)
    opcode_tb = `STORE;	#5;	// alu_op should return 0
    // 3. opcode = JALR -> alu_op = ADD	(4'b0000)
    opcode_tb = `JALR; 	#5;	// alu_op should return 0
    #20;

    $finish;
  end

  always #5 clk_tb = ~clk_tb;

endmodule
