##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group DESIGN -radix dec /inst_mgmt_tb/inst_inst_mgmt/clk
add wave -expand -group DESIGN -radix dec /inst_mgmt_tb/inst_inst_mgmt/rst
add wave -expand -group DESIGN -radix dec /inst_mgmt_tb/inst_inst_mgmt/inst_sel
add wave -expand -group DESIGN -radix dec /inst_mgmt_tb/inst_inst_mgmt/rdata
add wave -expand -group DESIGN -radix dec /inst_mgmt_tb/inst_inst_mgmt/inst

add wave -expand -group TB -radix dec /inst_mgmt_tb/clk_tb
add wave -expand -group TB -radix dec /inst_mgmt_tb/rst_tb
add wave -expand -group TB -radix dec /inst_mgmt_tb/inst_sel_tb
add wave -expand -group TB -radix dec /inst_mgmt_tb/rdata_tb
add wave -expand -group TB -radix dec /inst_mgmt_tb/inst_tb

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
