/*
	By Mozerpol
*/

`define OP                  5'b01100
`define STORE	            5'b01000
`define JALR	            5'b11001
`define	OP_IMM	            5'b00100
`define LUI		            5'b01101
`define JAL		            5'b11011
`define BRANCH	            5'b11000
`define LOAD                5'b00000
`define FUNC3_ADD_SUB	    3'b000
`define FUNC3_SLT		    3'b010
`define FUNC3_XOR		    3'b100
`define FUNC3_SLL		    3'b001
`define FUNC3_SR		    3'b101
`define FUNC3_BRANCH_BEQ	3'b000
`define FUNC3_BRANCH_BGE 	3'b101
`define FUNC3_BRANCH_BLTU	3'b110
`define FUNC3_SH		    3'b001
`define FUNC3_SBU		    3'b100
`define FUNC3_SHU		    3'b101
`define FUNC7_SR_SRL		7'b0000000
`define FUNC7_SR_SRA		7'b0100000
`define FUNC7_ADD_SUB_SUB	7'b0100000
`define FUNC7_ADD_SUB_ADD	7'b0000000

module ctrl_tb;
  reg clk_tb = 1'b1;
  reg rst_tb;
  opcodePkg::opcode opcode_tb;
  //reg [4:0] opcode_tb;
  reg [2:0] func3_tb;
  reg [6:0] func7_tb;
  reg b_tb;
  immPkg::imm_type imm_type_tb; // imm_mux.sv
  instMgmtPkg::inst_sel inst_sel_tb; // inst_mgmt.sv
  wire reg_wr_tb;
  aluPkg::alu_op alu_op_tb; // alu.sv
  cmpPkg::cmp_op cmp_op_tb; // cmp.sv
  pcPkg::pc_sel pc_sel_tb; // mem_addr_sel.sv
  pcPkg::mem_sel mem_sel_tb; // mem_addr_sel.sv
  rdPkg::rd_sel rd_sel_tb; // rd_mux.sv
  alu1Pkg::alu1_sel alu1_sel_tb; // alu1_mux.sv
  alu2Pkg::alu2_sel alu2_sel_tb; // alu2_mux.sv
  selectPkg::sel_type sel_type_tb; // select_pkg.sv
  wire we_tb;

  ctrl uut(
    .clk(clk_tb),
    .rst(rst_tb),
    .opcode(opcode_tb),
    .func3(func3_tb),
    .func7(func7_tb),
    .b(b_tb),
    .imm_type(imm_type_tb),
    .inst_sel(inst_sel_tb),
    .reg_wr(reg_wr_tb),
    .alu_op(alu_op_tb),
    .cmp_op(cmp_op_tb),
    .pc_sel(pc_sel_tb),
    .mem_sel(mem_sel_tb),
    .rd_sel(rd_sel_tb),
    .alu1_sel(alu1_sel_tb),
    .alu2_sel(alu2_sel_tb),
    .sel_type(sel_type_tb),
    .we(we_tb)
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;

    //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    //		Test for first always_comb, which control ALU
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

    $finish;   
  end
  
  always #5 clk_tb = ~clk_tb;

endmodule
