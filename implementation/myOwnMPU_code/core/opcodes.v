`timescale 100ns / 10ns

'define LOAD =		5'b00000
`define LOAD_FP =	5'b00001
`define CUSTOM_0 =	5'b00010
`define MISC_MEM =	5'b00011
`define OP_IMM =	5'b00100

module opcode(
  input wire [5:0] opcode_in,
  output wire [5:0] opcode_out
);

  reg [5:0] o;
  assign opcode_out = o;
  
  always@(*)
    begin
      case(opcode_in)
        0 : o = 'LOAD;
        1 : o = 5'b00001;
      endcase
    end
endmodule


// https://stackoverflow.com/questions/65767011/using-define-inside-case-statement-not-working
