##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group testbench         -radix dec /riscpol_tb/set_test_point

add wave -expand -group riscpol_DESIGN   -radix bin /riscpol_tb/inst_riscpol/i_rst
add wave         -group riscpol_DESIGN   -radix bin /riscpol_tb/inst_riscpol/i_clk
add wave         -group riscpol_DESIGN   -radix bin /riscpol_tb/inst_riscpol/o_gpio

add wave         -group GPIO              -radix dec /riscpol_tb/inst_riscpol/inst_gpio/i_addr
add wave         -group GPIO              -radix hex /riscpol_tb/inst_riscpol/inst_gpio/i_wdata
add wave         -group GPIO              -radix bin /riscpol_tb/inst_riscpol/inst_gpio/o_gpio

add wave         -group RAM               -radix dec /riscpol_tb/inst_riscpol/inst_memory/raddr
add wave         -group RAM               -radix dec /riscpol_tb/inst_riscpol/inst_memory/waddr
add wave         -group RAM               -radix bin /riscpol_tb/inst_riscpol/inst_memory/we
add wave         -group RAM               -radix hex /riscpol_tb/inst_riscpol/inst_memory/wdata
add wave         -group RAM               -radix bin /riscpol_tb/inst_riscpol/inst_memory/be
add wave         -group RAM               -radix hex /riscpol_tb/inst_riscpol/inst_memory/q
add wave         -group RAM               -radix hex /riscpol_tb/inst_riscpol/inst_memory/ram
add wave         -group RAM               -radix hex /riscpol_tb/p_tb/spy_ram

add wave         -group CORE              -radix hex /riscpol_tb/inst_riscpol/inst_core/i_core_data_read
add wave         -group CORE              -radix hex /riscpol_tb/inst_riscpol/inst_core/o_core_data_write
add wave         -group CORE              -radix bin /riscpol_tb/inst_riscpol/inst_core/o_core_write_enable
add wave         -group CORE              -radix bin /riscpol_tb/inst_riscpol/inst_core/o_core_byte_enable
add wave         -group CORE              -radix dec /riscpol_tb/inst_riscpol/inst_core/o_core_addr_read
add wave         -group CORE              -radix dec /riscpol_tb/inst_riscpol/inst_core/o_core_addr_write

add wave         -group ALU               -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu/i_alu_operand_1
add wave         -group ALU               -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu/i_alu_operand_2
add wave         -group ALU               -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_alu/i_alu_control
add wave         -group ALU               -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu/o_alu_result

add wave         -group ALU_1_MUX         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_1/i_alu_mux_1_ctrl
add wave         -group ALU_1_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_1/i_rs1_data
add wave         -group ALU_1_MUX         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_1/i_pc_addr
add wave         -group ALU_1_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_1/o_alu_operand_1

add wave         -group ALU_2_MUX         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_2/i_alu_mux_2_ctrl
add wave         -group ALU_2_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_2/i_rs2_data
add wave         -group ALU_2_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_2/i_imm
add wave         -group ALU_2_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_2/o_alu_operand_2

add wave         -group BRANCH_INST       -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_branch_instructions/i_branch_ctrl
add wave         -group BRANCH_INST       -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_branch_instructions/i_rs1_data
add wave         -group BRANCH_INST       -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_branch_instructions/i_rs2_data
add wave         -group BRANCH_INST       -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_branch_instructions/o_branch_result

add wave         -group CONTROL           -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_control/i_opcode
add wave         -group CONTROL           -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_control/i_func3
add wave         -group CONTROL           -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_control/i_func7
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/i_branch_result
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_alu_mux_1_ctrl
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_alu_mux_2_ctrl
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_pc_ctrl
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_inst_addr_ctrl
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_alu_control
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_ram_management_ctrl
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_reg_file_inst_ctrl
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_reg_file_wr_ctrl
add wave         -group CONTROL           -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_branch_ctrl

add wave         -group DECODER           -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/i_instruction
add wave         -group DECODER           -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_rd_addr
add wave         -group DECODER           -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_rs1_addr
add wave         -group DECODER           -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_rs2_addr
add wave         -group DECODER           -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_imm
add wave         -group DECODER           -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_opcode
add wave         -group DECODER           -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_func3
add wave         -group DECODER           -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_func7

add wave         -group INSTRUCTION_MEM   -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_instruction_memory/i_instruction_addr
add wave         -group INSTRUCTION_MEM   -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_instruction_memory/o_instruction

add wave         -group PC                -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/i_alu_result
add wave         -group PC                -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/i_pc_ctrl
add wave         -group PC                -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/i_inst_addr_ctrl
add wave         -group PC                -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/o_pc_addr
add wave         -group PC                -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/o_instruction_addr

add wave         -group RAM_MNGT          -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/i_ram_management_ctrl
add wave         -group RAM_MNGT          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/i_rs1_data
add wave         -group RAM_MNGT          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/i_rs2_data
add wave         -group RAM_MNGT          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/i_imm
add wave         -group RAM_MNGT          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/i_data_from_ram
add wave         -group RAM_MNGT          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/o_rd_data
add wave         -group RAM_MNGT          -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/p_ram_management/v_ram_address
add wave         -group RAM_MNGT          -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/p_reg_file/v_reg_file_address
add wave         -group RAM_MNGT          -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/o_write_enable
add wave         -group RAM_MNGT          -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/o_byte_enable
add wave         -group RAM_MNGT          -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/o_raddr
add wave         -group RAM_MNGT          -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/o_waddr
add wave         -group RAM_MNGT          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_ram_management/o_data

add wave         -group REG_FILE          -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_rs1_addr
add wave         -group REG_FILE          -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_rs2_addr
add wave         -group REG_FILE          -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_rd_addr
add wave         -group REG_FILE          -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_reg_file_inst_ctrl
add wave         -group REG_FILE          -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_reg_file_wr_ctrl
add wave         -group REG_FILE          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_rd_data
add wave         -group REG_FILE          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_alu_result
add wave         -group REG_FILE          -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_pc_addr
add wave         -group REG_FILE          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/o_rs2_data
add wave         -group REG_FILE          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/o_rs1_data
add wave         -group REG_FILE          -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/gpr


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
