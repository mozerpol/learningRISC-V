/*
	Theoretically it's not necessary include "mux" file to project. I hope... I compiled project
    without this file and everything worked correct, so I suppose that it's not necessary. Moreover
    there is one problem... This code refuses to compile under the old Verilog version :D
    The prblem is with this line: "wire [DATA_WIDTH-1:0] inputs[INPUTS-1:0];". Unpacked
    arrays are supported since SystemVerilog (or Verilog 2005, but I'm not sure). Anyway
    it looks this code is not necessary.
*/

// Below function act as system function $clog2. Below function is necessary, because
// in old v. of Verilog you can't use this system function. 
function integer clog2;
  input integer value;
  begin
    value = value-1;
    for(clog2=0; value>0; clog2=clog2+1)
      value = value>>1;
  end
endfunction

module mux(inputs, addr, out);  
  parameter DATA_WIDTH = 32,  
  INPUTS = 2,
  ADDR_WIDTH= clog2(INPUTS);

  input inputs;
  input addr;
  output out;

  wire [DATA_WIDTH-1:0] inputs[INPUTS-1:0];
  wire [ADDR_WIDTH-1:0] addr;
  wire [DATA_WIDTH-1:0] out;

  assign out = inputs[addr];
endmodule
