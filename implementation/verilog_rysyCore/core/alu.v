`include "rysy_pkg.vh"
`include "alu.vh"

module alu(
  input wire [`REG_LEN-1:0] alu_in1,
  input wire [`REG_LEN-1:0] alu_in2,
  input wire [3:0] alu_op,
  output wire [`REG_LEN-1:0] alu_out
);

  reg signed [`REG_LEN-1:0] o; // if we want connect "output wire" from module to the result from
  // our instructions, it's necessary. 
  wire signed [`REG_LEN-1:0] alu_in1_s; // "_s" - variable for SRA and SLT instruction. Without
  // modifier signed the result for bigger numbers than 2^32 will be wrong.
  wire signed [`REG_LEN-1:0] alu_in2_s;

  assign alu_out = o; // it's necessary, because we want assign two "input wire" to the one var.
  assign alu_in1_s = alu_in1;
  assign alu_in2_s = alu_in2;

  always@(alu_op, alu_in1, alu_in2) 
    begin
      case(alu_op)
        `ADD : o = alu_in1 + alu_in2;
        `SUB : o = alu_in1 - alu_in2;
        `XOR : o = alu_in1 ^ alu_in2;
        `OR  : o = alu_in1 | alu_in2;
        `AND : o = alu_in1 & alu_in2;
        `SLL : o = alu_in1 << alu_in2[4:0];
        `SRL : o = alu_in1 >> alu_in2[4:0];
        `SRA : o = alu_in1_s >>> alu_in2_s[4:0];
        `SLT : o = alu_in1_s < alu_in2_s;
        `SLTU : o = alu_in1 < alu_in2;
        default: o = 0;
      endcase
    end

endmodule
