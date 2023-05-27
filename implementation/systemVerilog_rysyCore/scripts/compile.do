#-
# SPDX-License-Identifier: BSD-3-Clause
#
# Copyright (c) 2019 Rafal Kozik
# All rights reserved.
#

vlib work

vlog ../core/rysy_pkg.sv
vlog ../core/opcodes.sv
vlog ../core/instruction.sv
vlog ../core/select_pkg.sv

vlog ../core/imm_mux.sv
vlog ../core/mem_addr_sel.sv
vlog ../core/inst_mgmt.sv
vlog ../core/rd_mux.sv
vlog ../core/alu1_mux.sv
vlog ../core/alu2_mux.sv
vlog ../core/alu.sv
vlog ../core/reg_file.sv
vlog ../core/decode.sv
vlog ../core/mux.sv
vlog ../core/cmp.sv
vlog ../core/select_wr.sv
vlog ../core/select_rd.sv

vlog ../core/ctrl.sv
vlog ../core/rysy_core.sv

vlog ../core/reg_file_tb.sv
vlog ../core/decode_tb.sv
vlog ../core/mux_tb.sv
vlog ../core/alu_tb.sv
vlog ../core/cmp_tb.sv
vlog ../core/select_wr_tb.sv
vlog ../core/select_rd_tb.sv

vlog ../peripheral/bus_interconnect.sv
vlog ../peripheral/byte_enabled_simple_dual_port_ram.sv
vlog ../peripheral/gpio.sv

vlog ../rysy.sv
vlog ../rysy_tb.sv
