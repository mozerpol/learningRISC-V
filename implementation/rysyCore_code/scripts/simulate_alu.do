#-
# SPDX-License-Identifier: BSD-3-Clause
#
# Copyright (c) 2019 Rafal Kozik
# All rights reserved.
#

vsim -novopt work.alu_tb

add wave -position end -dec sim:/alu_tb/in1
add wave -position end -dec sim:/alu_tb/in2
add wave -position end  sim:/alu_tb/op
add wave -position end -dec sim:/alu_tb/dut/alu_out

run -all
wave zoom full