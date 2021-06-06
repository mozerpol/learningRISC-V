/*
	Mozerpol
*/

`timescale 100ns / 10ns

module reg_file_tb;

  reg clk_tb;
  reg [4:0]rs1_addr_tb;
  reg [4:0]rs2_addr_tb;
  reg [4:0]rd_addr_tb;
  reg [31:0]rd_data_tb;
  reg wr_tb;
  wire [31:0]rs1_data_tb;
  wire [31:0]rs2_data_tb;

  reg_file uut(
    .clk(clk_tb),
    .rs1(rs1_addr_tb),
    .rs2(rs2_addr_tb),
    .rd(rd_addr_tb),
    .rd_d(rd_data_tb),
    .reg_wr(wr_tb),
    .rs1_d(rs1_data_tb),
    .rs2_d(rs2_data_tb)
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;

    rs1_addr_tb <= 0;
    rs2_addr_tb <= 0;
    rd_addr_tb <= 0;
    rd_data_tb <= 0;
    wr_tb <= 0;
    #30;
    rd_data_tb <= 32'h00000001;
    rd_addr_tb <= 5'h01;
    wr_tb <= 1;
    #5;
    wr_tb <= 0;
    rd_data_tb <= 32'h00000002;
    rd_addr_tb <= 5'h03;
    #5;
    wr_tb <= 1;
    #5;
    wr_tb <= 0;
    rs1_addr_tb <= 5'h01;
    #10;
    rs2_addr_tb <= 5'h03;
    #10
    rd_addr_tb <= 5'h0;
    wr_tb <= 1;
    rs1_addr_tb <= 5'h0;
    
    #20 $finish;
  end

  initial begin
    clk_tb <= 1'b1;
    forever
      #5 clk_tb <= ~clk_tb;
  end

endmodule
