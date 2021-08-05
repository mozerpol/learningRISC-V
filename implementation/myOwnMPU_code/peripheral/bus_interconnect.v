`timescale 100ns / 10ns

module bus_interconnect 
  #(parameter WIDTH = 32) (
    input wire clk,
    input wire [WIDTH-1:0] addr,
    input wire [WIDTH-1:0] rdata_gpio,
    input wire [WIDTH-1:0] rdata_ram,
    input wire we,
    output wire [WIDTH-1:0] rdata,
    output wire we_ram,
    output wire we_gpio
  );
  reg [3:0] next_select;
  reg [WIDTH-1:0] rdata_reg;
  assign rdata = rdata_reg;

  always@(posedge clk)
    next_select <= addr[31:28];

  always@(*)
    case(next_select)
      4'd2: rdata_reg = rdata_gpio;
      default: rdata_reg = rdata_ram;
    endcase

  assign we_ram = we & (addr[31:28] != 4'd2);
  assign we_gpio = we & (addr[31:28] == 4'd2);

endmodule
