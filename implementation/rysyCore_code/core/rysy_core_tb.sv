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
    #20
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
        imm			in	decode			=	101 (5 in dec)
        imm_type	in	ctrl/imm_mux	=	00100 (4 in dec)
        imm			in	imm_mux			=	101
		
		
    */
    rdata_tb = 32'b000000000101_00001_000_00010_0010011;

    #50; $finish;   
  end

  always #5 clk_tb = ~clk_tb;

endmodule
