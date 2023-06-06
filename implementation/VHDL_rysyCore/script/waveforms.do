##### Add wave command description: #####
# add wave -expand -group GROUP_NAME -radix system_name /dir_to_signal/signal_name
# -expand -- expand signal from group after opening window with waveforms
# -group GROUP_NAME -- group the signals by GROUP_NAME
# -radix system_name -- show signal in specific format, eg. bitary, octal, etc.


##### Add waves: #####
add wave -expand -group DESIGN_PORTS        -radix binary      /rysy_tb/inst_rysy/i_clk 
add wave         -group DESIGN_PORTS        -radix binary      /rysy_tb/inst_rysy/i_rst
add wave         -group DESIGN_PORTS        -radix binary      /rysy_tb/inst_rysy/o_gpio

add wave         -group DESIGN_SIGNALS      -radix hex         /rysy_tb/inst_rysy/CODE 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/i_clk 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/i_rst 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/o_gpio 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/addr 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/rdata 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/rdata_ram 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/rdata_gpio 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/wdata 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/be 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/we 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/we_ram 
add wave         -group DESIGN_SIGNALS      -radix binary      /rysy_tb/inst_rysy/we_gpio 

add wave         -group BUS_INTERCONNECT    -radix binary      /rysy_tb/inst_rysy/inst_bus_interconnect/*
add wave         -group BYTE_ENABLE_RAM     -radix binary      /rysy_tb/inst_rysy/inst_byte_enabled_simple_dual_port_ram/*
add wave         -group GPIO                -radix binary      /rysy_tb/inst_rysy/inst_gpio/*

add wave         -group CTRL                -radix binary      /rysy_tb/inst_rysy/inst_core/inst_ctrl/*
add wave         -group INST_MGMT           -radix binary      /rysy_tb/inst_rysy/inst_core/inst_inst_mgtm/*
add wave         -group MEM_ADDR_SEL        -radix binary      /rysy_tb/inst_rysy/inst_core/inst_mem_addr_sel/*
add wave         -group DECODE              -radix binary      /rysy_tb/inst_rysy/inst_core/inst_decode/*
add wave         -group SELECT_RD           -radix binary      /rysy_tb/inst_rysy/inst_core/inst_select_rd/*
add wave         -group REG_FILE            -radix binary      /rysy_tb/inst_rysy/inst_core/inst_reg_file/*
add wave         -group IMM_MUX             -radix binary      /rysy_tb/inst_rysy/inst_core/inst_imm_mux/*
add wave         -group RD_MUX              -radix binary      /rysy_tb/inst_rysy/inst_core/inst_rd_mux/*
add wave         -group ALU1_MUX            -radix binary      /rysy_tb/inst_rysy/inst_core/inst_alu1_mux/*
add wave         -group ALU2_MUX            -radix binary      /rysy_tb/inst_rysy/inst_core/inst_alu2_mux/*
add wave         -group CMP                 -radix binary      /rysy_tb/inst_rysy/inst_core/inst_cmp/*
add wave         -group ALU                 -radix binary      /rysy_tb/inst_rysy/inst_core/inst_alu/*
add wave         -group SELECT_WR           -radix binary      /rysy_tb/inst_rysy/inst_core/inst_select_wr/*

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
