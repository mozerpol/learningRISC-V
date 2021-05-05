#-
# SPDX-License-Identifier: BSD-3-Clause
#
# Copyright (c) 2019 Rafal Kozik
# All rights reserved.
#

vsim -novopt work.rysy_tb -GCODE=code/blink.mem

add wave -position end sim:/rysy_tb/clk
add wave -position end sim:/rysy_tb/dut/core/rst
add wave -position end -hex sim:/rysy_tb/dut/core/reg_file1/x\[1\]
add wave -position end -hex sim:/rysy_tb/dut/core/reg_file1/x\[2\]
add wave -position end -hex sim:/rysy_tb/dut/core/reg_file1/x\[3\]
add wave -position end -hex sim:/rysy_tb/dut/gpio1/gpio_state
add wave -position end sim:/rysy_tb/gpio

run 60us
wave zoom full