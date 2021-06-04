/*
 * Mozerpol 2021
 */

`timescale 100ns / 10ns

module rd_mux_tb;

  reg [31:0] imm_tb;
  reg [31:0] pc_tb;
  reg [31:0] alu_out_tb;
  reg [31:0] rd_mem_tb;
  reg clk_tb = 1;
  reg [1:0] rd_sel_tb;
  wire [31:0] rd_d_tb;

  rd_mux uut(
    .imm(imm_tb),
    .pc(pc_tb),
    .alu_out(alu_out_tb),
    .rd_mem(rd_mem_tb),
    .clk(clk_tb),
    .rd_sel(rd_sel_tb),
    .rd_d(rd_d_tb)
  );

  integer i, j;
  reg [31:0] val_for_imm [0:4];

  initial
    begin
      $dumpfile("dump.vcd"); 
      $dumpvars;

      val_for_imm[0] = 32'd10;
      val_for_imm[1] = 32'd3;
      val_for_imm[2] = -32'd4;
      val_for_imm[3] = 32'd4;
      val_for_imm[4] = -32'd16;

      for(i = 0; i < 4; i=i+1)
        begin
          #5 rd_sel_tb = i; 
          
          for(j = 0; j < 5; j=j+1)
            begin
              imm_tb = val_for_imm[j]; 
              #5;
            end
        end

      #10 $finish;
    end

  always #5 clk_tb = ~clk_tb;  
endmodule
