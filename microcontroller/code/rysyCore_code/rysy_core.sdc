## SPDX-License-Identifier: BSD-3-Clause
## Copyright (c) 2019 Rafal Kozik

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports { clk }]

set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  

