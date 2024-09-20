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
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "ALU"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu.i_alu_operand_1
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "ALU_1_MUX"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_1.i_alu_mux_1_ctrl
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "ALU_2_MUX"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_alu_mux_2.i_alu_mux_2_ctrl
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "BRANCH_INST"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_branch_instructions.i_branch_ctrl
gtkwave::/Edit/Insert_Blank

gtkwave::/Edit/Insert_Comment "CONTROL"
gtkwave::addSignalsFromList top.riscpol_tb.inst_riscpol.inst_core.inst_control.i_opcode
gtkwave::/Edit/Insert_Blank







gtkwave::/Time/Zoom/Zoom_Full
