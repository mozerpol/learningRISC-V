##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group DESIGN -radix bin /ram_management_tb/inst_ram_management/i_rst
add wave -expand -group DESIGN -radix bin /ram_management_tb/inst_ram_management/i_ram_management_ctrl
add wave -expand -group DESIGN -radix hex /ram_management_tb/inst_ram_management/i_rs1_data
add wave -expand -group DESIGN -radix hex /ram_management_tb/inst_ram_management/i_rs2_data
add wave -expand -group DESIGN -radix hex /ram_management_tb/inst_ram_management/i_imm
add wave -expand -group DESIGN -radix bin /ram_management_tb/inst_ram_management/i_load_inst_ctrl
add wave -expand -group DESIGN -radix hex /ram_management_tb/inst_ram_management/i_data_from_ram
add wave -expand -group DESIGN -radix hex /ram_management_tb/inst_ram_management/p_ram_management/v_address_row
add wave -expand -group DESIGN -radix hex /ram_management_tb/inst_ram_management/p_ram_management/v_address_column
add wave -expand -group DESIGN -radix hex /ram_management_tb/inst_ram_management/o_rd_data
add wave -expand -group DESIGN -radix bin /ram_management_tb/inst_ram_management/o_write_enable
add wave -expand -group DESIGN -radix bin /ram_management_tb/inst_ram_management/o_byte_enable
add wave -expand -group DESIGN -radix dec /ram_management_tb/inst_ram_management/o_raddr
add wave -expand -group DESIGN -radix dec /ram_management_tb/inst_ram_management/o_waddr
add wave -expand -group DESIGN -radix hex /ram_management_tb/inst_ram_management/o_data


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
