##### Add wave command description: #####
# add wave -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.

##### Add waves: #####

add wave -group PORTS -radix binary /rysy_core_tb/we_tb
add wave -group PORTS -radix binary /rysy_core_tb/wdata_tb
add wave -group PORTS -radix binary /rysy_core_tb/rst_tb
add wave -group PORTS -radix binary /rysy_core_tb/rdata_tb
add wave -group PORTS -radix binary /rysy_core_tb/clk_tb
add wave -group PORTS -radix binary /rysy_core_tb/be_tb
add wave -group PORTS -radix binary /rysy_core_tb/addr_tb

add wave -group MEM_ADDR_SEL -radix binary /rysy_core_tb/inst_rysy_core/inst_mem_addr_sel/clk 
add wave -group MEM_ADDR_SEL -radix binary /rysy_core_tb/inst_rysy_core/inst_mem_addr_sel/rst 
add wave -group MEM_ADDR_SEL -radix binary /rysy_core_tb/inst_rysy_core/inst_mem_addr_sel/pc_sel 
add wave -group MEM_ADDR_SEL -radix binary /rysy_core_tb/inst_rysy_core/inst_mem_addr_sel/mem_sel 
add wave -group MEM_ADDR_SEL -radix binary /rysy_core_tb/inst_rysy_core/inst_mem_addr_sel/alu_out 
add wave -group MEM_ADDR_SEL -radix binary /rysy_core_tb/inst_rysy_core/inst_mem_addr_sel/pc 
add wave -group MEM_ADDR_SEL -radix binary /rysy_core_tb/inst_rysy_core/inst_mem_addr_sel/addr 

add wave -group MGMT -radix binary /rysy_core_tb/inst_rysy_core/inst_inst_mgtm/clk 
add wave -group MGMT -radix binary /rysy_core_tb/inst_rysy_core/inst_inst_mgtm/rst 
add wave -group MGMT -radix binary /rysy_core_tb/inst_rysy_core/inst_inst_mgtm/inst_sel 
add wave -group MGMT -radix binary /rysy_core_tb/inst_rysy_core/inst_inst_mgtm/rdata 
add wave -group MGMT -radix binary /rysy_core_tb/inst_rysy_core/inst_inst_mgtm/inst 

add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/inst 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/rd 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/rs1 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/rs2 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/imm_I 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/imm_S 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/imm_B 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/imm_U 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/imm_J 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/opcode 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/func3 
add wave -group DECODE -radix binary /rysy_core_tb/inst_rysy_core/inst_decode/func7 

add wave -group IMM_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_imm_mux/imm_type 
add wave -group IMM_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_imm_mux/imm_J 
add wave -group IMM_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_imm_mux/imm_U 
add wave -group IMM_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_imm_mux/imm_B 
add wave -group IMM_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_imm_mux/imm_S 
add wave -group IMM_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_imm_mux/imm_I 
add wave -group IMM_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_imm_mux/imm 

add wave -group SELECT_RD -radix binary /rysy_core_tb/inst_rysy_core/inst_select_rd/rdata 
add wave -group SELECT_RD -radix binary /rysy_core_tb/inst_rysy_core/inst_select_rd/sel_type 
add wave -group SELECT_RD -radix binary /rysy_core_tb/inst_rysy_core/inst_select_rd/sel_addr_old 
add wave -group SELECT_RD -radix binary /rysy_core_tb/inst_rysy_core/inst_select_rd/rd_mem 

add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/ADDR_LEN 
add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/clk 
add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/reg_wr 
add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/rs1 
add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/rs2 
add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/rd 
add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/rd_d 
add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/rs1_d 
add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/rs2_d 
add wave -group REG_FILE -radix binary /rysy_core_tb/inst_rysy_core/inst_reg_file/x 

add wave -group RD_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_rd_mux/imm 
add wave -group RD_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_rd_mux/pc 
add wave -group RD_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_rd_mux/alu_out 
add wave -group RD_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_rd_mux/rd_mem 
add wave -group RD_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_rd_mux/clk 
add wave -group RD_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_rd_mux/rd_sel 
add wave -group RD_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_rd_mux/rd_d 
add wave -group RD_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_rd_mux/old_pc 

add wave -group ALU1_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu1_mux/rs1_d 
add wave -group ALU1_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu1_mux/pc 
add wave -group ALU1_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu1_mux/alu1_sel 
add wave -group ALU1_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu1_mux/clk 
add wave -group ALU1_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu1_mux/alu_in1
add wave -group ALU1_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu1_mux/old_pc 

add wave -group ALU2_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu2_mux/rs2_d 
add wave -group ALU2_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu2_mux/imm 
add wave -group ALU2_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu2_mux/alu2_sel 
add wave -group ALU2_MUX -radix binary /rysy_core_tb/inst_rysy_core/inst_alu2_mux/alu_in2

add wave -group ALU -radix binary /rysy_core_tb/inst_rysy_core/inst_alu/alu_in1 
add wave -group ALU -radix binary /rysy_core_tb/inst_rysy_core/inst_alu/alu_in2 
add wave -group ALU -radix binary /rysy_core_tb/inst_rysy_core/inst_alu/alu_op 
add wave -group ALU -radix binary /rysy_core_tb/inst_rysy_core/inst_alu/alu_out 

add wave -group CMP -radix binary /rysy_core_tb/inst_rysy_core/inst_cmp/rs1_d 
add wave -group CMP -radix binary /rysy_core_tb/inst_rysy_core/inst_cmp/rs2_d 
add wave -group CMP -radix binary /rysy_core_tb/inst_rysy_core/inst_cmp/cmp_op 
add wave -group CMP -radix binary /rysy_core_tb/inst_rysy_core/inst_cmp/b 

add wave -group SELECT_WR -radix binary /rysy_core_tb/inst_rysy_core/inst_select_wr/wdata 
add wave -group SELECT_WR -radix binary /rysy_core_tb/inst_rysy_core/inst_select_wr/sel_type 
add wave -group SELECT_WR -radix binary /rysy_core_tb/inst_rysy_core/inst_select_wr/sel_addr 
add wave -group SELECT_WR -radix binary /rysy_core_tb/inst_rysy_core/inst_select_wr/rs2_d 
add wave -group SELECT_WR -radix binary /rysy_core_tb/inst_rysy_core/inst_select_wr/be 

add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/we 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/sel_type 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/rst 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/reg_wr 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/rd_sel 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/pc_sel 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/opcode 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/next_nop 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/mem_sel 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/load_phase 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/inst_sel 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/imm_type 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/func7 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/func3 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/cmp_op 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/clk 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/b 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/alu_op 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/alu2_sel 
add wave -group CTRL -radix binary /rysy_core_tb/inst_rysy_core/inst_ctrl/alu1_sel

add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/clk 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rst 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rdata 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/wdata 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/addr 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/we
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/be
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/pc_sel 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/mem_sel 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu_out 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/pc
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/inst_sel 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/inst 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rd 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rs1
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rs2 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_I
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_S 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_B 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_U 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_J
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/opcode 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/func3 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/func7 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm_type
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/imm 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/sel_type 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/sel_addr 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/sel_addr_old 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rd_mem
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/reg_wr 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rd_d
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rs1_d 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rs2_d
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/rd_sel 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu1_sel 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu_in1 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu2_sel 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu_in2 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/alu_op 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/cmp_op 
add wave -group DESIGN -radix binary /rysy_core_tb/inst_rysy_core/b 

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
