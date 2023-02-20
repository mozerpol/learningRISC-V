##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group TB -radix dec /alu2_mux_tb/rs2_d_tb
add wave -expand -group TB -radix dec /alu2_mux_tb/imm_tb
add wave -expand -group TB -radix bin /alu2_mux_tb/alu2_sel_tb
add wave -expand -group TB -radix dec /alu2_mux_tb/alu2_in2_tb
add wave -expand -group TB -radix dec /alu2_mux_tb/val_for_rs2_d
add wave -expand -group TB -radix dec /alu2_mux_tb/val_for_imm

add wave -expand -group DESIGN -radix dec /alu2_mux_tb/inst_alu2_mux/rs2_d
add wave -expand -group DESIGN -radix dec /alu2_mux_tb/inst_alu2_mux/imm
add wave -expand -group DESIGN -radix bin /alu2_mux_tb/inst_alu2_mux/alu2_sel
add wave -expand -group DESIGN -radix dec /alu2_mux_tb/inst_alu2_mux/alu2_in2
add wave -expand -group DESIGN -radix dec /alu2_mux_tb/inst_alu2_mux/o

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
