module mux(inputs, addr, out);  
  parameter DATA_WIDTH = 32,  
  INPUTS = 2,
  ADDR_WIDTH= $clog2(INPUTS);

  input inputs;
  input addr;
  output out;

  wire [DATA_WIDTH-1:0] inputs[INPUTS-1:0];
  wire [ADDR_WIDTH-1:0] addr;
  wire [DATA_WIDTH-1:0] out;

  assign out = inputs[addr];
endmodule
