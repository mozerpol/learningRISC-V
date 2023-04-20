##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.

##### Add waves: #####
add wave -expand -group TB -radix dec /reg_file_tb/clk_tb
add wave -expand -group TB -radix dec /reg_file_tb/rs1_tb
add wave -expand -group TB -radix dec /reg_file_tb/rs2_tb 
add wave -expand -group TB -radix dec /reg_file_tb/rd_tb
add wave -expand -group TB -radix dec /reg_file_tb/rd_d_tb
add wave -expand -group TB -radix dec /reg_file_tb/reg_wr_tb
add wave -expand -group TB -radix dec /reg_file_tb/rs1_d_tb 
add wave -expand -group TB -radix dec /reg_file_tb/rs2_d_tb

##### Waveform window settings: #####
quietly wave cursor active 1
configure wave -namecolwidth 194
configure wave -valuecolwidth 125
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
