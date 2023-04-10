##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.

##### Add waves: #####
add wave -expand -group TB -radix dec /rd_mux_tb/clk_tb
add wave -expand -group TB -radix dec /rd_mux_tb/imm_tb
add wave -expand -group TB -radix dec /rd_mux_tb/pc_tb
add wave -expand -group TB -radix dec /rd_mux_tb/alu_out_tb
add wave -expand -group TB -radix dec /rd_mux_tb/rd_mem_tb
add wave -expand -group TB -radix dec /rd_mux_tb/rd_sel_tb
add wave -expand -group TB -radix dec /rd_mux_tb/rd_d_tb 

add wave -expand -group DESIGN -radix dec /rd_mux_tb/inst_rd_mux/clk
add wave -expand -group DESIGN -radix dec /rd_mux_tb/inst_rd_mux/imm 
add wave -expand -group DESIGN -radix dec /rd_mux_tb/inst_rd_mux/pc
add wave -expand -group DESIGN -radix dec /rd_mux_tb/inst_rd_mux/alu_out
add wave -expand -group DESIGN -radix dec /rd_mux_tb/inst_rd_mux/rd_mem
add wave -expand -group DESIGN -radix dec /rd_mux_tb/inst_rd_mux/rd_sel
add wave -expand -group DESIGN -radix dec /rd_mux_tb/inst_rd_mux/rd_d

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
