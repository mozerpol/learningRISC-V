##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group MAIN_DESIGN -radix bin  /main_tb/inst_main/i_rst 
add wave         -group MAIN_DESIGN -radix bin  /main_tb/inst_main/i_clk

add wave         -group RAM -radix hex          /main_tb/inst_main/inst_memory/o_instruction
add wave         -group RAM -radix dec          /main_tb/inst_main/inst_memory/i_ram_read_addr 
add wave         -group RAM -radix hex          /main_tb/inst_main/inst_memory/i_ram_write_data 
add wave         -group RAM -radix dec          /main_tb/inst_main/inst_memory/i_ram_write_addr 
add wave         -group RAM -radix bin          /main_tb/inst_main/inst_memory/i_ram_write_enable 
add wave         -group RAM -radix hex          /main_tb/inst_main/inst_memory/ram

add wave         -group CORE -radix hex         /main_tb/inst_main/inst_core/i_instruction_read 
add wave         -group CORE -radix dec         /main_tb/inst_main/inst_core/o_addr_read
add wave         -group CORE -radix hex         /main_tb/inst_main/inst_core/o_instruction_write 
add wave         -group CORE -radix dec         /main_tb/inst_main/inst_core/o_addr_write
add wave         -group CORE -radix dec         /main_tb/inst_main/inst_core/o_write_enable


   
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
