`timescale 100ns / 10ns

module decode_tb();

  reg [31:0] inst_tb;

  decode uut(
    .inst(inst_tb)
  );

  initial 
    begin
      $dumpfile("tb.vcd"); 
      $dumpvars;

      inst_tb = 32'b0;
      #1 inst_tb <= 32'h002081b3;
      // Test for R-type, ADD instruction:
      /*
        ADD x3, x1, x2 is equal 002081b3 in machine code
        002081b3 in hex = 0000000 00010 00001 000 00011 0110011 in bin, where:
        0  -  6:  0110011 - opcode  =  33 in hex
        7  - 11:  00011   - rd      =  3  in hex
        12 - 14:  000     - funct3  =  0  in hex
        15 - 19:  00001   - rs1     =  1  in hex
        20 - 24:  00010   - rs2     =  2  in hex
        25 - 31:  0000000 - funct7  =  0  in hex
      */

      #1 inst_tb <= 32'h05408113;
      // Test for I-type, ADDI instruction:
      /*
      	ADDI x2 x1 0x54 is equal 05408113 in machine code
        05408113 in hex = 0000001010100 00001 000 00010 0010011 in bin, where:
        0  -  6:  0010011       - opcode  =  13 in hex
        7  - 11:  00010         - rd      =  2  in hex
        12 - 14:  000           - funct3  =  0  in hex
        15 - 19:  00001         - rs1     =  1  in hex
        20 - 31:  0000001010100 - imm     =  54 in hex
      */

      #1 inst_tb <= 32'h000230B7; 
      // Test for U-type, LUI instruction:
      /* 
      	LUI x1 0x23 is equal 000230B7 in machine code
        000230B7 in hex = 00000000000000100011 00001 0110111 in bin, where:
        0 -   6:  0110111              - opcode  =  37 in hex
        7 -  11:  00001                - rd      =  1  in hex
        12 - 31:  00000000000000100011 - imm     =  23 in hex
      */


      #1 $finish;

    end

endmodule
