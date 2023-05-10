##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group DESIGN -radix dec /alu_tb/inst_alu/alu_in1
add wave -expand -group DESIGN -radix dec /alu_tb/inst_alu/alu_in2
add wave -expand -group DESIGN -radix dec /alu_tb/inst_alu/alu_op
add wave -expand -group DESIGN -radix dec /alu_tb/inst_alu/alu_out

add wave -expand -group TB -radix dec  /alu_tb/val_for_in1
add wave -expand -group TB -radix dec  /alu_tb/val_for_in2
add wave -expand -group TB -radix dec  /alu_tb/alu_in1_tb
add wave -expand -group TB -radix dec  /alu_tb/alu_in2_tb
add wave -expand -group TB -radix dec  /alu_tb/alu_op_tb
add wave -expand -group TB -radix dec  /alu_tb/alu_out_tb

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
