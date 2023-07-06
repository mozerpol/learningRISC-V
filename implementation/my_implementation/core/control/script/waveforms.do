##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group TB -radix bin /control_tb/inst_control/i_rst 
add wave -expand -group TB -radix bin /control_tb/inst_control/i_opcode 
add wave -expand -group TB -radix bin /control_tb/inst_control/i_func3 
add wave -expand -group TB -radix bin /control_tb/inst_control/i_func7
add wave -expand -group TB -radix bin /control_tb/inst_control/o_alu_mux_1_ctrl 
add wave -expand -group TB -radix bin /control_tb/inst_control/o_alu_mux_2_ctrl 
add wave -expand -group TB -radix bin /control_tb/inst_control/o_control_alu 
add wave -expand -group TB -radix bin /control_tb/inst_control/o_reg_wr_ctrl


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
