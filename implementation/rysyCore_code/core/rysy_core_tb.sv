/*
	By Mozerpol
*/

module rysy_core_tb;
  reg clk_tb = 1'b1;
  reg rst_tb;
  reg [31:0] rdata_tb;
  wire [31:0] wdata_tb;
  wire [31:0] addr_tb;
  wire we_tb;
  wire [3:0] be_tb;

  rysy_core dut(
    .clk(clk_tb),
    .rst(rst_tb),
    .rdata(rdata_tb),
    .wdata(wdata_tb),
    .addr(addr_tb),
    .we(we_tb),
    .be(be_tb)
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    $monitor("time: %d | addr: %d | rdata: %d | rdata_bin: %b | \n", $time, addr_tb, rdata_tb, rdata_tb); 

    #10;
    /*
    	....:::::rst_tb = 1;:::::....
        next_nop	in	ctrl		=	1
        load_phase	in	ctrl		=	0
        inst_sel	in	ctrl		= 	01
        inst		in	inst_mgmt	=	32'b10011
        pc_reg		in	mem_addr_sel=	0
    */
    rst_tb = 1;
    #20
    /*
    	....:::::rst_tb = 0;:::::....
        next_nop	in	ctrl		=	0
        load_phase	in	ctrl		=	0
        inst_sel	in	ctrl		= 	10
        inst		in	inst_mgmt	=	32'b10011
        pc_reg		in	mem_addr_sel=	100 (4 in dec, next clk will is 8...)
    */
    rst_tb = 0;
    #20 // 
    /* 
    	....:::::rdata_tb = 32'b000000000101_00001_000_00010_0010011;:::::....
        This instruction means: addi x2, x1, 0x5
		inst 		in	inst_mgmt		=	rdata
        inst_sel	in	inst_mgmt		=	10 (INST_MEM)
        inst_sel	in	ctrl			=	10 (INST_MEM)
        opcode		in	decode			=	00100 (4 in dec) (OP_IMM in opcodes)
        func3		in	decode			=	000
        rd			in	decode			=	00010
        rs1			in	decode			=	1
        rs2			in 	decode			=	101
        imm_type	in	ctrl/imm_mux	=	00100 (4 in dec)
        imm			in	imm_mux			=	101
        reg_wr		in	ctrl/reg_file	=	1
    */
    rdata_tb = 32'b000000000101_00001_000_00010_0010011;
    #20
    rst_tb = 1;
    #20
    rst_tb = 0;
    #20
    rdata_tb = 32'b010101010101_00000_111_00001_0010011; // andi x1, x0, 0b010101010101
    #20
    rdata_tb = 32'b000000000101_00001_000_00010_0010011; // addi x2, x1, 0x5
    #20
    rdata_tb = 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2
    #20
    rdata_tb = 32'b0000000000100_00001_010_00010_0010011; // slti x2, x1, 4
    #20
    rdata_tb = 32'b100000000000_00001_011_00010_0010011; // sltiu x2, x1, -2048
    #20
    rst_tb = 1;
    #20
    rst_tb = 0;
    #20 
    rdata_tb = 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2
    #20 
    rdata_tb = 32'b11111111111111111111_00101_0010111; // auipc x5, 0xfffff
    #20
    rdata_tb = 32'b1111111_00001_00010_001_11001_1100011; // bne x2, x1, loop - loop is label
    #20
    rdata_tb = 32'b11111111100111111111_00100_1101111; // jal x4, loop
    #20
    rst_tb = 1;
    #20
    rst_tb = 0;
    #20
    rdata_tb = 32'b11111111111111111111_00001_0110111; // lui x1, 0xFFFFF
    #20
    rdata_tb = 32'b010101010101_00000_110_00001_0010011; // ori x1, x0, 0b10101010101
    #20
    rdata_tb = 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2
    #20
    rdata_tb = 32'b0000000000100_00001_010_00010_0010011; // slti x2, x1, 4
    #20
    rdata_tb = 32'b100000000000_00001_011_00010_0010011; // sltiu x2, x1, -2048
    #20
    rdata_tb = 32'b000000000101_00001_000_00010_0010011; // addi x2, x1, 0x5
    #20
    rdata_tb = 32'b010101010101_00000_111_00001_0010011; // andi x1, x0, 0b010101010101
    #20
    rdata_tb = 32'b000000000101_00001_000_00010_0010011; // addi x2, x1, 0x5
    #20
    rdata_tb = 32'b010101010101_00000_111_00001_0010011; // andi x1, x0, 0b010101010101
    #20
    rdata_tb = 32'b000000000101_00001_000_00010_0010011; // addi x2, x1, 0x5
    #20
    rdata_tb = 32'b010101010101_00000_111_00001_0010011; // andi x1, x0, 0b010101010101
    #20
    rdata_tb = 32'b000000000101_00001_000_00010_0010011; // addi x2, x1, 0x5
    #20 
    rdata_tb = 32'b11111111111111111111_00101_0010111; // auipc x5, 0xfffff
    #20
    rdata_tb = 32'b1111111_00001_00010_001_11001_1100011; // bne x2, x1, loop - loop is label

    #50; $finish;   
  end

  always #5 clk_tb = ~clk_tb;

endmodule
