##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group MAIN_DESIGN -radix bin  /main_tb/inst_main/i_rst
add wave         -group MAIN_DESIGN -radix bin  /main_tb/inst_main/i_clk
add wave         -group MAIN_DESIGN -radix hex  /main_tb/inst_main/i_instruction
add wave         -group MAIN_DESIGN -radix hex  /main_tb/inst_main/o_ram_read_data
add wave         -group MAIN_DESIGN -radix hex  /main_tb/inst_main/o_ram_write_data
add wave         -group MAIN_DESIGN -radix dec  /main_tb/inst_main/o_ram_read_addr
add wave         -group MAIN_DESIGN -radix dec  /main_tb/inst_main/o_ram_write_addr
add wave         -group MAIN_DESIGN -radix bin  /main_tb/inst_main/o_ram_write_enable

add wave         -group RAM -radix bin          /main_tb/inst_main/inst_memory/i_rst
add wave         -group RAM -radix bin          /main_tb/inst_main/inst_memory/i_clk 
add wave         -group RAM -radix hex          /main_tb/inst_main/inst_memory/i_ram_read_addr 
add wave         -group RAM -radix hex          /main_tb/inst_main/inst_memory/i_ram_write_addr 
add wave         -group RAM -radix hex          /main_tb/inst_main/inst_memory/i_ram_write_data 
add wave         -group RAM -radix bin          /main_tb/inst_main/inst_memory/i_ram_write_enable 
add wave         -group RAM -radix hex          /main_tb/inst_main/inst_memory/o_instruction
add wave         -group RAM -radix hex          /main_tb/inst_main/inst_memory/ram

add wave         -group ALU -radix dec          /main_tb/inst_main/inst_alu/i_rst 
add wave         -group ALU -radix dec          /main_tb/inst_main/inst_alu/i_alu_operand_1
add wave         -group ALU -radix dec          /main_tb/inst_main/inst_alu/i_alu_operand_2
add wave         -group ALU -radix dec          /main_tb/inst_main/inst_alu/i_alu_control
add wave         -group ALU -radix dec          /main_tb/inst_main/inst_alu/o_alu_result

add wave         -group ALU_1_MUX -radix bin    /main_tb/inst_main/inst_alu_mux_1/i_rst 
add wave         -group ALU_1_MUX -radix bin    /main_tb/inst_main/inst_alu_mux_1/i_alu_mux_1_ctrl 
add wave         -group ALU_1_MUX -radix dec    /main_tb/inst_main/inst_alu_mux_1/i_rs1_data 
add wave         -group ALU_1_MUX -radix dec    /main_tb/inst_main/inst_alu_mux_1/i_pc_addr 
add wave         -group ALU_1_MUX -radix dec    /main_tb/inst_main/inst_alu_mux_1/o_alu_operand_1 

add wave         -group ALU_2_MUX -radix bin    /main_tb/inst_main/inst_alu_mux_2/i_rst 
add wave         -group ALU_2_MUX -radix bin    /main_tb/inst_main/inst_alu_mux_2/i_alu_mux_2_ctrl 
add wave         -group ALU_2_MUX -radix dec    /main_tb/inst_main/inst_alu_mux_2/i_rs2_data 
add wave         -group ALU_2_MUX -radix dec    /main_tb/inst_main/inst_alu_mux_2/i_imm 
add wave         -group ALU_2_MUX -radix dec    /main_tb/inst_main/inst_alu_mux_2/o_alu_operand_2

add wave         -group CONTROL -radix bin      /main_tb/inst_main/inst_control/i_rst 
add wave         -group CONTROL -radix bin      /main_tb/inst_main/inst_control/i_opcode 
add wave         -group CONTROL -radix bin      /main_tb/inst_main/inst_control/i_func3 
add wave         -group CONTROL -radix bin      /main_tb/inst_main/inst_control/i_func7
add wave         -group CONTROL -radix bin      /main_tb/inst_main/inst_control/o_alu_mux_1_ctrl 
add wave         -group CONTROL -radix bin      /main_tb/inst_main/inst_control/o_alu_mux_2_ctrl 
add wave         -group CONTROL -radix bin      /main_tb/inst_main/inst_control/o_alu_control
add wave         -group CONTROL -radix bin      /main_tb/inst_main/inst_control/o_reg_wr_ctrl

add wave         -group DECODER -radix bin      /main_tb/inst_main/inst_decoder/i_rst 
add wave         -group DECODER -radix hex      /main_tb/inst_main/inst_decoder/i_instruction
add wave         -group DECODER -radix dec      /main_tb/inst_main/inst_decoder/o_rd_addr
add wave         -group DECODER -radix dec      /main_tb/inst_main/inst_decoder/o_rs1_addr
add wave         -group DECODER -radix dec      /main_tb/inst_main/inst_decoder/o_rs2_addr
add wave         -group DECODER -radix hex      /main_tb/inst_main/inst_decoder/o_imm
add wave         -group DECODER -radix dec      /main_tb/inst_main/inst_decoder/o_opcode
add wave         -group DECODER -radix bin      /main_tb/inst_main/inst_decoder/o_func3
add wave         -group DECODER -radix bin      /main_tb/inst_main/inst_decoder/o_func7

add wave         -group REG_FILE -radix bin     /main_tb/inst_main/inst_reg_file/i_rst 
add wave         -group REG_FILE -radix bin     /main_tb/inst_main/inst_reg_file/i_clk 
add wave         -group REG_FILE -radix dec     /main_tb/inst_main/inst_reg_file/i_rs1_addr
add wave         -group REG_FILE -radix dec     /main_tb/inst_main/inst_reg_file/i_rs2_addr
add wave         -group REG_FILE -radix dec     /main_tb/inst_main/inst_reg_file/i_rd_addr
add wave         -group REG_FILE -radix bin     /main_tb/inst_main/inst_reg_file/i_reg_wr_ctrl
add wave         -group REG_FILE -radix hex     /main_tb/inst_main/inst_reg_file/i_alu_result
add wave         -group REG_FILE -radix hex     /main_tb/inst_main/inst_reg_file/o_rs1_data
add wave         -group REG_FILE -radix hex     /main_tb/inst_main/inst_reg_file/o_rs2_data
add wave         -group REG_FILE -radix hex     /main_tb/inst_main/inst_reg_file/gpr
   
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
