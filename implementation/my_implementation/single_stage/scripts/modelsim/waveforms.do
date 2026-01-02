# Script to automatically add wawveforms for ModelSim during simulation.

# Add wave command description:
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name


##### Waveforms: #####
add wave -expand -group testbench         -radix dec /riscpol_tb/test_point


add wave -expand -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/i_rst_n
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/i_clk
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/io_gpio
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/i_uart_rx
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/o_uart_tx
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/o_7segment_1
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/o_7segment_2
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/o_7segment_3
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/o_7segment_4
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/o_7segment_anodes
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/o_spi_mosi
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/i_spi_miso
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/o_spi_ss_n
add wave         -group riscpol_DESIGN         -radix bin /riscpol_tb/inst_riscpol/o_spi_sclk


add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_mmio_we_ram
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_mmio_we_gpio
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_mmio_re_gpio
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_mmio_we_cnt1
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix hex /riscpol_tb/inst_riscpol/s_mmio_data
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix hex /riscpol_tb/inst_riscpol/s_core_data_write
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_core_write_enable
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_core_byte_enable
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix dec /riscpol_tb/inst_riscpol/s_core_addr_read
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix dec /riscpol_tb/inst_riscpol/s_core_addr_write
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix hex /riscpol_tb/inst_riscpol/s_ram_q
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix dec /riscpol_tb/inst_riscpol/s_cnt1_q
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_q_gpio
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_mmio_we_7seg
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/s_7segment_1_tb
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/s_7segment_2_tb
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/s_7segment_3_tb
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/s_7segment_4_tb
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/s_7segment_anodes_tb
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix hex /riscpol_tb/inst_riscpol/s_mmio_data_spi
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_mmio_we_spi_ctrl
add wave         -group riscpol_DESIGN -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/s_mmio_we_spi_data


add wave         -group ALU         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu/i_alu_operand_1
add wave         -group ALU         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu/i_alu_operand_2
add wave         -group ALU         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_alu/i_alu_control
add wave         -group ALU         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu/o_alu_result


add wave         -group ALU_1_MUX         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_1/i_alu_mux_1_ctrl
add wave         -group ALU_1_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_1/i_rs1_data
add wave         -group ALU_1_MUX         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_1/i_pc_addr
add wave         -group ALU_1_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_1/o_alu_operand_1


add wave         -group ALU_2_MUX         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_2/i_alu_mux_2_ctrl
add wave         -group ALU_2_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_2/i_rs2_data
add wave         -group ALU_2_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_2/i_imm
add wave         -group ALU_2_MUX         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_alu_mux_2/o_alu_operand_2


add wave         -group BRANCH_INST         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_branch_instructions/i_branch_ctrl
add wave         -group BRANCH_INST         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_branch_instructions/i_rs1_data
add wave         -group BRANCH_INST         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_branch_instructions/i_rs2_data
add wave         -group BRANCH_INST         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_branch_instructions/o_branch_result


add wave         -group CONTROL         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_control/i_opcode
add wave         -group CONTROL         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_control/i_func3
add wave         -group CONTROL         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_control/i_func7
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/i_branch_result
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_alu_mux_1_ctrl
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_alu_mux_2_ctrl
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_pc_ctrl
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_inst_addr_ctrl
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_alu_control
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_data_mem_mgmt_ctrl
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_reg_file_inst_ctrl
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_data_source_ctrl
add wave         -group CONTROL         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_control/o_branch_ctrl


add wave         -group DECODER         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/i_instruction
add wave         -group DECODER         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_rd_addr
add wave         -group DECODER         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_rs1_addr
add wave         -group DECODER         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_rs2_addr
add wave         -group DECODER         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_imm
add wave         -group DECODER         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_opcode
add wave         -group DECODER         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_func3
add wave         -group DECODER         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_decoder/o_func7


add wave         -group INSTRUCTION_MEM         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_instruction_memory/i_instruction_addr
add wave         -group INSTRUCTION_MEM         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_instruction_memory/o_instruction


add wave         -group PC         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/i_alu_result
add wave         -group PC         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/i_pc_ctrl
add wave         -group PC         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/i_inst_addr_ctrl
add wave         -group PC         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/pc_addr_buff
add wave         -group PC         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_program_counter/o_pc_addr


add wave         -group DATA_MEM_MNGT         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/i_data_mem_mgmt_ctrl
add wave         -group DATA_MEM_MNGT         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/i_rs1_data
add wave         -group DATA_MEM_MNGT         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/i_rs2_data
add wave         -group DATA_MEM_MNGT         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/i_imm
add wave         -group DATA_MEM_MNGT         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/p_data_mem_mgmt/v_ram_address
add wave         -group DATA_MEM_MNGT         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/o_write_enable
add wave         -group DATA_MEM_MNGT         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/o_byte_enable
add wave         -group DATA_MEM_MNGT         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/o_raddr
add wave         -group DATA_MEM_MNGT         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/o_waddr
add wave         -group DATA_MEM_MNGT         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_data_mem_mgmt/o_data


add wave         -group REG_FILE         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_rs1_addr
add wave         -group REG_FILE         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_rs2_addr
add wave         -group REG_FILE         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_imm
add wave         -group REG_FILE         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_rd_addr
add wave         -group REG_FILE         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_data_from_mmio
add wave         -group REG_FILE         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_data_source_ctrl
add wave         -group REG_FILE         -radix bin /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_reg_file_inst_ctrl
add wave         -group REG_FILE         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/p_reg_file_management/v_reg_file_address
add wave         -group REG_FILE         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_alu_result
add wave         -group REG_FILE         -radix dec /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/i_pc_addr
add wave         -group REG_FILE         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/o_rs2_data
add wave         -group REG_FILE         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/o_rs1_data
add wave         -group REG_FILE         -radix hex /riscpol_tb/inst_riscpol/inst_core/inst_reg_file/gpr


add wave         -group CORE         -radix hex /riscpol_tb/inst_riscpol/inst_core/i_core_data_read
add wave         -group CORE         -radix hex /riscpol_tb/inst_riscpol/inst_core/o_core_data_write
add wave         -group CORE         -radix bin /riscpol_tb/inst_riscpol/inst_core/o_core_write_enable
add wave         -group CORE         -radix bin /riscpol_tb/inst_riscpol/inst_core/o_core_byte_enable
add wave         -group CORE         -radix dec /riscpol_tb/inst_riscpol/inst_core/o_core_addr_read
add wave         -group CORE         -radix dec /riscpol_tb/inst_riscpol/inst_core/o_core_addr_write


add wave         -group MMIO         -radix dec /riscpol_tb/inst_riscpol/inst_mmio/i_mmio_raddr
add wave         -group MMIO         -radix dec /riscpol_tb/inst_riscpol/inst_mmio/i_mmio_waddr
add wave         -group MMIO         -radix bin /riscpol_tb/inst_riscpol/inst_mmio/i_mmio_write_enable
add wave         -group MMIO         -radix hex /riscpol_tb/inst_riscpol/inst_mmio/i_mmio_q_cnt1
add wave         -group MMIO         -radix hex /riscpol_tb/inst_riscpol/inst_mmio/i_mmio_q_gpio
add wave         -group MMIO         -radix hex /riscpol_tb/inst_riscpol/inst_mmio/i_mmio_data_ram
add wave         -group MMIO         -radix hex /riscpol_tb/inst_riscpol/inst_mmio/i_mmio_data_uart
add wave         -group MMIO         -radix hex /riscpol_tb/inst_riscpol/inst_mmio/i_mmio_status_uart
add wave         -group MMIO         -radix hex /riscpol_tb/inst_riscpol/inst_mmio/i_mmio_data_spi
add wave         -group MMIO         -radix dec /riscpol_tb/inst_riscpol/inst_mmio/o_mmio_we_cnt1
add wave         -group MMIO         -radix bin /riscpol_tb/inst_riscpol/inst_mmio/o_mmio_we_gpio
add wave         -group MMIO         -radix bin /riscpol_tb/inst_riscpol/inst_mmio/o_mmio_re_gpio
add wave         -group MMIO         -radix bin /riscpol_tb/inst_riscpol/inst_mmio/o_mmio_we_ram
add wave         -group MMIO         -radix hex /riscpol_tb/inst_riscpol/inst_mmio/o_mmio_we_7seg
add wave         -group MMIO         -radix bin /riscpol_tb/inst_riscpol/inst_mmio/o_mmio_we_uart
add wave         -group MMIO         -radix bin /riscpol_tb/inst_riscpol/inst_mmio/o_mmio_we_spi_ctrl
add wave         -group MMIO         -radix bin /riscpol_tb/inst_riscpol/inst_mmio/o_mmio_we_spi_data
add wave         -group MMIO         -radix hex /riscpol_tb/inst_riscpol/inst_mmio/o_mmio_data


add wave         -group GPIO         -radix hex /riscpol_tb/inst_riscpol/inst_gpio/i_gpio_wdata
add wave         -group GPIO         -radix bin /riscpol_tb/inst_riscpol/inst_gpio/i_gpio_we
add wave         -group GPIO         -radix bin /riscpol_tb/inst_riscpol/inst_gpio/i_gpio_re
add wave         -group GPIO         -radix bin /riscpol_tb/inst_riscpol/inst_gpio/reg_gpio_q
add wave         -group GPIO         -radix bin /riscpol_tb/inst_riscpol/inst_gpio/o_gpio_q


add wave         -group CNT1         -radix bin /riscpol_tb/inst_riscpol/inst_counter1/i_cnt1_we
add wave         -group CNT1         -radix bin /riscpol_tb/inst_riscpol/inst_counter1/i_cnt1_set_reset
#add wave        -group CNT1         -radix dec /riscpol_tb/inst_riscpol/inst_counter1/line__32/v_cnt
add wave         -group CNT1         -radix dec /riscpol_tb/inst_riscpol/inst_counter1/o_cnt1_q
add wave         -group CNT1         -radix dec /riscpol_tb/inst_riscpol/inst_counter1/o_cnt1_overflow
add wave         -group CNT1  -group INTERNAL_SIGNALS         -radix dec /riscpol_tb/inst_riscpol/inst_counter1/s_ce_latch


add wave         -group UART         -radix dec /riscpol_tb/inst_riscpol/inst_uart/G_BAUD
add wave         -group UART         -radix hex /riscpol_tb/inst_riscpol/inst_uart/i_uart_wdata
add wave         -group UART         -radix bin /riscpol_tb/inst_riscpol/inst_uart/i_uart_rx
add wave         -group UART         -radix bin /riscpol_tb/inst_riscpol/inst_uart/i_uart_we
add wave         -group UART         -radix hex /riscpol_tb/inst_riscpol/inst_uart/o_uart_data
add wave         -group UART         -radix hex /riscpol_tb/inst_riscpol/inst_uart/o_uart_status
add wave         -group UART         -radix bin /riscpol_tb/inst_riscpol/inst_uart/o_uart_tx
add wave         -group UART -group TX         -radix hex /riscpol_tb/inst_riscpol/inst_uart/uart_state_tx
add wave         -group UART -group TX         -radix hex /riscpol_tb/inst_riscpol/inst_uart/uart_buff_tx
add wave         -group UART -group TX         -radix dec /riscpol_tb/inst_riscpol/inst_uart/bit_cnt_tx
add wave         -group UART -group TX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/s_status_tx_busy
add wave         -group UART -group TX         -radix dec /riscpol_tb/inst_riscpol/inst_uart/inst_counter_tx/G_COUNTER1_VALUE
add wave         -group UART -group TX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/inst_counter_tx/i_cnt1_set_reset
add wave         -group UART -group TX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/inst_counter_tx/i_cnt1_we
add wave         -group UART -group TX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/inst_counter_tx/o_cnt1_overflow
add wave         -group UART -group TX         -radix dec /riscpol_tb/inst_riscpol/inst_uart/inst_counter_tx/o_cnt1_q
add wave         -group UART -group TX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/inst_counter_tx/s_ce_latch

add wave         -group UART -group RX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/i_uart_rx
add wave         -group UART -group RX         -radix hex /riscpol_tb/inst_riscpol/inst_uart/uart_state_rx
add wave         -group UART -group RX         -radix hex /riscpol_tb/inst_riscpol/inst_uart/uart_buff_rx
add wave         -group UART -group RX         -radix dec /riscpol_tb/inst_riscpol/inst_uart/bit_cnt_rx
add wave         -group UART -group RX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/s_status_rx_ready
add wave         -group UART -group RX         -radix dec /riscpol_tb/inst_riscpol/inst_uart/inst_counter_rx/G_COUNTER1_VALUE
add wave         -group UART -group RX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/inst_counter_rx/i_cnt1_set_reset
add wave         -group UART -group RX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/inst_counter_rx/i_cnt1_we
add wave         -group UART -group RX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/inst_counter_rx/o_cnt1_overflow
add wave         -group UART -group RX         -radix dec /riscpol_tb/inst_riscpol/inst_uart/inst_counter_rx/o_cnt1_q
add wave         -group UART -group RX         -radix bin /riscpol_tb/inst_riscpol/inst_uart/inst_counter_rx/s_ce_latch


add wave         -group 7SEGMENT         -radix hex /riscpol_tb/inst_riscpol/inst_seven_segment/i_7segment_wdata
add wave         -group 7SEGMENT         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/i_7segment_we
add wave         -group 7SEGMENT         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/o_7segment_1
add wave         -group 7SEGMENT         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/o_7segment_2
add wave         -group 7SEGMENT         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/o_7segment_3
add wave         -group 7SEGMENT         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/o_7segment_4
add wave         -group 7SEGMENT         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/o_7segment_anodes
add wave         -group 7SEGMENT -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/s_7segment_1
add wave         -group 7SEGMENT -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/s_7segment_2
add wave         -group 7SEGMENT -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/s_7segment_3
add wave         -group 7SEGMENT -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/inst_seven_segment/s_7segment_4


add wave -expand -group SPI         -radix dec /riscpol_tb/inst_riscpol/inst_spi/G_SPI_FREQUENCY_HZ
add wave         -group SPI         -radix bin /riscpol_tb/inst_riscpol/inst_spi/o_spi_ss_n
add wave         -group SPI         -radix bin /riscpol_tb/inst_riscpol/inst_spi/o_spi_sclk
add wave         -group SPI         -radix bin /riscpol_tb/inst_riscpol/inst_spi/o_spi_mosi
add wave         -group SPI         -radix hex /riscpol_tb/inst_riscpol/inst_spi/reg_spi_mosi
add wave         -group SPI         -radix bin /riscpol_tb/inst_riscpol/inst_spi/i_spi_miso
add wave         -group SPI         -radix hex /riscpol_tb/inst_riscpol/inst_spi/i_spi_wdata
add wave         -group SPI         -radix bin /riscpol_tb/inst_riscpol/inst_spi/i_spi_we_ctrl
add wave         -group SPI         -radix bin /riscpol_tb/inst_riscpol/inst_spi/i_spi_we_data
add wave         -group SPI         -radix hex /riscpol_tb/inst_riscpol/inst_spi/o_spi_data
add wave         -group SPI         -radix bin /riscpol_tb/inst_riscpol/inst_spi/o_spi_status
add wave         -group SPI         -radix bin /riscpol_tb/inst_riscpol/inst_spi/s_spi_sclk
add wave         -group SPI         -radix dec /riscpol_tb/inst_riscpol/inst_spi/p_spi_clock_gen/v_cnt_bits
add wave         -group SPI -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/inst_spi/fsm_tx
add wave         -group SPI -group INTERNAL_SIGNALS         -radix bin /riscpol_tb/inst_riscpol/inst_spi/s_rising_edge_sclk_tx
add wave         -group SPI -group INTERNAL_SIGNALS         -radix dec /riscpol_tb/inst_riscpol/inst_spi/bit_cnt_tx
add wave         -group SPI -group INTERNAL_SIGNALS         -radix hex /riscpol_tb/inst_riscpol/inst_spi/reg_spi_miso
add wave         -group SPI -group COUNTER         -radix dec /riscpol_tb/inst_riscpol/inst_spi/inst_counter/G_COUNTER1_VALUE
add wave         -group SPI -group COUNTER         -radix bin /riscpol_tb/inst_riscpol/inst_spi/inst_counter/o_cnt1_overflow
add wave         -group SPI -group COUNTER         -radix bin /riscpol_tb/inst_riscpol/inst_spi/inst_counter/i_cnt1_set_reset
add wave         -group SPI -group COUNTER         -radix bin /riscpol_tb/inst_riscpol/inst_spi/inst_counter/i_cnt1_we


add wave         -group RAM         -radix dec /riscpol_tb/inst_riscpol/inst_ram/i_ram_raddr
add wave         -group RAM         -radix dec /riscpol_tb/inst_riscpol/inst_ram/i_ram_waddr
add wave         -group RAM         -radix bin /riscpol_tb/inst_riscpol/inst_ram/i_ram_we
add wave         -group RAM         -radix hex /riscpol_tb/inst_riscpol/inst_ram/i_ram_wdata
add wave         -group RAM         -radix bin /riscpol_tb/inst_riscpol/inst_ram/i_ram_be
add wave         -group RAM         -radix hex /riscpol_tb/inst_riscpol/inst_ram/o_ram_data
add wave         -group RAM         -radix hex /riscpol_tb/inst_riscpol/inst_ram/ram
#add wave        -group RAM         -radix hex /riscpol_tb/p_tb/spy_ram


# Waveform window settings:
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
