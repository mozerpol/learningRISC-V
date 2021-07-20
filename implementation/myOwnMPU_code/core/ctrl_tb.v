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

    $finish;
  end

  always #5 clk_tb = ~clk_tb;

endmodule
