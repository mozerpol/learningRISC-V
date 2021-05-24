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
      
      #5 inst_tb = 32'b0;
      #5 inst_tb = 32'b00000001001000001000000110110011;
      #5 $finish;
      
    end

endmodule
