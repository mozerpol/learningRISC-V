##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.

##### Add waves: #####
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/clk 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/rst 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/opcode 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/func3 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/func7 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/b 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/reg_wr 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/we 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/imm_type 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/alu1_sel 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/alu2_sel 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/rd_sel 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/pc_sel 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/mem_sel 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/cmp_op 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/sel_type 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/inst_sel 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/alu_op 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/next_nop 
add wave -expand -group DESIGN -radix binary /ctrl_tb/inst_ctrl/load_phase

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
