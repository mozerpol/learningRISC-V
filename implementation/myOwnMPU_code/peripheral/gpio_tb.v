`timescale 100ns / 10ns

module gpio_tb;

  reg [7:0]addr;
  reg [3:0]be;
  reg [31:0]wdata;
  reg we;
  reg clk;
  reg rst;
  wire [31:0]q;
  wire [3:0]gpio;

  gpio uut(
    .addr(addr),
    .be(be),
    .wdata(wdata),
    .we(we),
    .clk(clk),
    .rst(rst),
    .q(q),
    .gpio(gpio)
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;

    #10
    rst = 1;
    #10
    rst = 0;
    addr = 8'b10010101;
    we = 1;
    wdata = 32'b000000000101_00001_000_00010_0010011; // addi x2, x1, 0x5
    #10
    we = 0;
    #10
    we = 1;
    addr = 8'b11111111;
    wdata = 32'b010101010101_00000_111_00001_0010011; // andi x1, x0, 0b010101010101
    #10
    addr = 8'b00000000;
    #10
    rst = 1;
    addr = 8'b10010101;
    #10
    rst = 0;
    we = 1;
    wdata = 32'b000000000100_00001_010_00010_0010011; // slti x2, x1, 4
    #10
    addr = 8'b00000000;
    wdata = 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2
    #10 
    wdata = 32'b11111111111111111111_00101_0010111; // auipc x5, 0xfffff
    #10 
    wdata = 32'b100000000000_00001_011_00010_0010011; // sltiu x2, x1, -2048    

    #10 $finish;
  end

  initial begin
    clk <= 1'b1;
    forever
      #5 clk <= ~clk;
  end

endmodule
