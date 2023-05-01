##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.

##### Add waves: #####
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/clk 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rst 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rdata 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/wdata 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/addr 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/we
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/be
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/pc_sel 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/mem_sel 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu_out 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/pc
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/inst_sel 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/inst 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rd 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rs1
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rs2 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_I
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_S 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_B 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_U 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_J
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/opcode 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/func3 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/func7 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_type
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/sel_type 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/sel_addr 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/sel_addr_old 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rd_mem
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/reg_wr 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rd_d
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rs1_d 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rs2_d
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rd_sel 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu1_sel 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu_in1 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu2_sel 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu_in2 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu_op 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/cmp_op 
add wave -expand -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/b 

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
