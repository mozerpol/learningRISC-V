`timescale 100ns / 10ns

module opcode(
  input wire [5:0] opcode_in,
  output wire [5:0] opcode_out
);

  localparam LOAD =		5'b00000;
  localparam LOAD_FP =	5'b00001;
  localparam CUSTOM_0 =	5'b00010;
  localparam MISC_MEM =	5'b00011;
  localparam OP_IMM =	5'b00100;

  reg [5:0] o;
  assign opcode_out = o;

  always@(opcode_in)
    begin
      case(opcode_in)
        0 : o =	LOAD;
        1 : o = LOAD_FP;
        2 : o = CUSTOM_0;
        3 : o = MISC_MEM;
        4 : o = OP_IMM;
      endcase
    end

endmodule


