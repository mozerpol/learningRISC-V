gtkwave::/Edit/Insert_Comment "testbench"
gtkwave::addSignalsFromList top.riscpol_tb.set_test_point
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "riscpol_DESIGN"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.i_rst
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.i_clk
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.o_gpio
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "GPIO"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_gpio.i_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_gpio.i_wdata
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_gpio.i_o_gpio
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "RAM"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_memory.raddr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_memory.waddr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_memory.we
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_memory.wdata
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_memory.be
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_memory.q
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_memory.ram
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_memory.spy_ram
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "CORE"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.i_core_data_read
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.o_core_data_write
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.o_core_write_enable
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.o_core_byte_enable
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.o_core_addr_read
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.o_core_addr_write
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "ALU"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu.i_alu_operand_1
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu.i_alu_operand_2
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu.i_alu_control
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu.o_alu_result
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "ALU_1_MUX"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_1.i_alu_mux_1_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_1.i_rs1_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_1.i_pc_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_1.o_alu_operand_1
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "ALU_2_MUX"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_2.i_alu_mux_2_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_2.i_rs2_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_2.i_imm
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_2.o_alu_operand_2
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "BRANCH_INST"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_branch_instructions.i_branch_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_branch_instructions.i_rs1_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_branch_instructions.i_rs2_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_branch_instructions.o_branch_result
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "CONTROL"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.i_opcode
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.i_func3
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.i_func7
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.i_branch_result
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.o_alu_mux_1_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.o_alu_mux_2_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.o_pc_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.o_inst_addr_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.o_alu_control
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.o_ram_management_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.o_reg_file_inst_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.o_branch_ctrl
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "DECODER"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_decoder.i_instruction
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_decoder.o_rd_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_decoder.o_rs1_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_decoder.o_rs2_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_decoder.o_imm
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_decoder.o_opcode
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_decoder.o_func3
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_decoder.o_func7
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "INSTRUCTION_MEM"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_instruction_memory.i_instruction_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_instruction_memory.o_instruction
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "PC"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_program_counter.i_alu_result
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_program_counter.i_pc_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_program_counter.i_inst_addr_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_program_counter.o_pc_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_program_counter.o_instruction_adde
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "RAM_MNGT"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.i_ram_management_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.i_rs1_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.i_rs2_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.i_imm
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.i_data_from_ram
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.o_rd_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.v_ram_address
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.v_reg_file_address
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.o_write_enable
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.o_byte_enable
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.o_raddr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.o_waddr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_ram_management.o_data
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "REG_FILE"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.i_rs1_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.i_rs2_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.i_rd_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.i_reg_file_inst_ctrl
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.i_rd_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.i_alu_result
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.i_pc_addr
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.o_rs2_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.o_rs1_data
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_reg_file.gpr
gtkwave::/Edit/Insert_Blank

# Customize view settings
gtkwave::/Time/Zoom/Zoom_Full
