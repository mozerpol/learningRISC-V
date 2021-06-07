/*
	Mozerpol
*/

`timescale 100ns / 10ns

module sel_type_tb;

  reg [2:0] sel_type_input_tb;
  
  sel_type uut(
    .sel_type_input(sel_type_input_tb)
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    
    sel_type_input_tb = 3'b000;
    #5 sel_type_input_tb = 3'b001;
    #5 sel_type_input_tb = 3'b010;
    #5 sel_type_input_tb = 3'b011;
    #5 sel_type_input_tb = 3'b100;
    #5;

  end
endmodule
