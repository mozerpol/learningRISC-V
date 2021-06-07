/*
	How reg_file module works...
    It has five inputs: rs1, rs2, rd, rd_d, reg_wr.
    And three outputs: wr, rs1_d, rs2_d.
    When we look at instruction format, e.g. ADD instruction we can see rs1 and rs2.
    rs1 means (probably) register source and is the first argument. rs2 is the second argument. 
    So if we have "ADD x3, x1, x2" - x1 is rs1 and x2 is rs2. rd means register destination and
    in our example rd is x2. In ADD instruction rs1, rs2 and rd need 5 bits of space, for this reason
    we have "parameter ADDR_LEN = 5". In some instructions (S-type and B-type) our rd is imm value, for
    this reason sometimes we must change value of parameter. "reg_wr" is input, which indicate when we
    want save to WDATA reg. When we want save to WDATA then we must put 1 to reg_wr.
*/

`timescale 100ns / 10ns

`include "rysy_pkg.vh"

module reg_file
  #(parameter ADDR_LEN = 5) (
    input wire clk,
    input wire reg_wr,
    input wire [ADDR_LEN-1:0]rs1,
    input wire [ADDR_LEN-1:0]rs2,
    input wire [ADDR_LEN-1:0]rd,
    input wire [`REG_LEN-1:0]rd_d,
    output wire [`REG_LEN-1:0]rs1_d,
    output wire [`REG_LEN-1:0]rs2_d
  );

  reg [`REG_LEN-1:0] x[`REG_NUM-1:0];

  assign rs1_d = (rs1 == 0) ? 32'd0 : x[rs1]; // This line is because reg x0 is always equal 0.
  // Output (rs1_d) is equal 0 when our source register (rs1 or rs2) is equal 0.
  assign rs2_d = (rs2 == 0) ? 32'd0 : x[rs2];

  always@(posedge clk)
    begin
      if(reg_wr) x[rd] <= rd_d;
    end

endmodule
