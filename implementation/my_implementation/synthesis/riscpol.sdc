create_clock -name {i_clk} -period 40.000 -waveform { 0.000 20.000 } [get_ports { i_clk }]

set_clock_uncertainty -rise_from [get_clocks {i_clk}] -rise_to [get_clocks {i_clk}]  0.040
set_clock_uncertainty -rise_from [get_clocks {i_clk}] -fall_to [get_clocks {i_clk}]  0.040
set_clock_uncertainty -fall_from [get_clocks {i_clk}] -rise_to [get_clocks {i_clk}]  0.040
set_clock_uncertainty -fall_from [get_clocks {i_clk}] -fall_to [get_clocks {i_clk}]  0.040
