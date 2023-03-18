##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.

##### Add waves: #####
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/inst
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/rd
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/rs1
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/rs2
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/imm_I
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/imm_S
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/imm_B
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/imm_U
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/imm_J
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/opcode
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/func3
add wave -expand -group DESIGN -radix dec /decode_tb/inst_decode/func7

add wave -expand -group TB -radix dec /decode_tb/inst_tb 
add wave -expand -group TB -radix dec /decode_tb/rd_tb 
add wave -expand -group TB -radix dec /decode_tb/rs1_tb 
add wave -expand -group TB -radix dec /decode_tb/rs2_tb 
add wave -expand -group TB -radix dec /decode_tb/imm_I_tb 
add wave -expand -group TB -radix dec /decode_tb/imm_S_tb 
add wave -expand -group TB -radix dec /decode_tb/imm_B_tb 
add wave -expand -group TB -radix dec /decode_tb/imm_U_tb 
add wave -expand -group TB -radix dec /decode_tb/imm_J_tb 
add wave -expand -group TB -radix dec /decode_tb/opcode_tb 
add wave -expand -group TB -radix dec /decode_tb/func3_tb 
add wave -expand -group TB -radix dec /decode_tb/func7_tb


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
