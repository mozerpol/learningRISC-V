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
    
    $finish;
  end

  always #5 clk_tb = ~clk_tb;

endmodule
