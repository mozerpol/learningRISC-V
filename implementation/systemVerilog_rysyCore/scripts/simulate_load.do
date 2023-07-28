#-
# SPDX-License-Identifier: BSD-3-Clause
#
# Copyright (c) 2019 Rafal Kozik
# All rights reserved.
#

vsim -voptargs=+acc work.rysy_tb -GCODE=code/load_sim.mem

add wave -position end sim:/rysy_tb/clk
add wave -position end sim:/rysy_tb/dut/core/rst
add wave -position end -hex sim:/rysy_tb/dut/core/pc
add wave -position end -hex sim:/rysy_tb/dut/core/addr
add wave -position end -hex sim:/rysy_tb/dut/ram/q
add wave -position end -hex sim:/rysy_tb/dut/core/inst_mgmt_1/inst
add wave -position end -dec sim:/rysy_tb/dut/core/reg_file1/x\[1\]

run 11us
wave zoom full
