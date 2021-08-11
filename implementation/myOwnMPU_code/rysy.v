/*
      By Mozerpol
*/

`timescale 100ns / 10ns

`include "opcodes.vh"
`include "instruction.v"
`include "rysy_pkg.vh"
`include "inst_mgmt.v"
`include "imm_mux.v"
`include "alu.v"
`include "cmp.v"
`include "mem_addr_sel.v"
`include "rd_mux.v"
`include "alu1_mux.v"
`include "alu2_mux.v"
`include "select_pkg.v"
`include "decode.v"
`include "select_rd.v"
`include "reg_file.v"
`include "select_wr.v"
`include "ctrl.v"
`include "rysy_core.v"
`include "gpio.v"
`include "byte_enabled_simple_dual_port_ram.v"
`include "bus_interconnect.v"

module rysy #(parameter CODE="blink_slow.mem") (
  input wire clk,
  input wire rst,
  output wire [3:0] gpio
);

  localparam WIDTH = 32;

  wire [WIDTH-1:0]addr;
  wire [WIDTH-1:0]rdata;
  wire [WIDTH-1:0]rdata_ram;
  wire [WIDTH-1:0]rdata_gpio;
  wire [WIDTH-1:0]wdata;
  wire [3:0]be;
  wire we;
  wire we_ram;
  wire we_gpio;

  rysy_core core(
    .clk(clk),
    .rst(~rst),
    .rdata(rdata),
    .wdata(wdata),
    .addr(addr),
    .we(we),
    .be(be)
  );

  bus_interconnect #(
    .WIDTH(WIDTH)
  ) i (
    .clk(clk),
    .addr(addr),
    .rdata_gpio(rdata_gpio),
    .rdata_ram(rdata_ram),
    .we(we),
    .rdata(rdata),
    .we_ram(we_ram),
    .we_gpio(we_gpio)
  
  );

  byte_enabled_simple_dual_port_ram #(
    .CODE(CODE)
  ) ram(
    .waddr(addr[9:2]),
    .raddr(addr[9:2]),
    .be(be),
    .wdata(wdata),
    .we(we_ram),
    .clk(clk),
    .q(rdata_ram)
  );

  gpio gpio1(
    .addr(addr[9:2]),
    .be(be),
    .wdata(wdata),
    .we(we_gpio),
    .clk(clk),
    .rst(~rst),
    .q(rdata_gpio),
    .gpio(gpio)
  );

endmodule