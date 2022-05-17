#-
# SPDX-License-Identifier: BSD-3-Clause
#
# Copyright (c) 2019 Rafal Kozik
# All rights reserved.
#

if {[info exists 1]} {
	set code $1;
} else {
	set code "code/regop.mem";
}
vsim -novopt work.rysy_tb -GCODE=$code

add wave -position end sim:/rysy_tb/clk
add wave -position end sim:/rysy_tb/rst
add wave -position end -hex sim:/rysy_tb/dut/ram/q
add wave -position end -hex sim:/rysy_tb/dut/core/addr
add wave -position end -hex sim:/rysy_tb/dut/core/pc
add wave -position end -hex sim:/rysy_tb/dut/core/inst_mgmt_1/inst
add wave -position end sim:/rysy_tb/dut/core/opcode
add wave -position end -hex sim:/rysy_tb/dut/core/imm_mux1/imm
add wave -position end -hex sim:/rysy_tb/dut/core/alu1/alu_in1
add wave -position end -hex sim:/rysy_tb/dut/core/alu1/alu_in2
add wave -position end sim:/rysy_tb/dut/core/alu_op
add wave -position end -hex sim:/rysy_tb/dut/core/alu1/alu_out
add wave -position end -hex sim:/rysy_tb/dut/core/rs1_d
add wave -position end -hex sim:/rysy_tb/dut/core/rs2_d
add wave -position end sim:/rysy_tb/dut/core/cmp_op
add wave -position end sim:/rysy_tb/dut/core/b
add wave -position end -hex sim:/rysy_tb/dut/core/reg_file1/x
add wave -position end sim:/rysy_tb/dut/core/sel_type
add wave -position end -hex sim:/rysy_tb/dut/core/sel_addr
add wave -position end sim:/rysy_tb/dut/core/be
add wave -position end -hex sim:/rysy_tb/dut/core/wdata
add wave -position end sim:/rysy_tb/dut/core/we
add wave -position end -hex sim:/rysy_tb/dut/ram/ram
add wave -position end sim:/rysy_tb/gpio
