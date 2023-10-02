##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_rst
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_clk
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_rs1_addr
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_rs2_addr
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_rd_addr
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_reg_file_inst_ctrl
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_reg_file_wr_ctrl
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_rd_data
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_alu_result
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/i_pc_addr
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/o_rs1_data
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/o_rs2_data
add wave -expand -group DESIGN -radix bin /reg_file_tb/inst_reg_file/gpr


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
