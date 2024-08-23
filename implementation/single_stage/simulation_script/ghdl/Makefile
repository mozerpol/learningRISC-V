all: clean analyze run_test_and__generate_waves display_waveforms

clean:
	rm -f *.cf

analyze:
	# Packages
	ghdl -a --std=08 --work=control_lib 				../../core/control_pkg.vhd
	ghdl -a --std=08 --work=opcodes 					../../core/opcodes.vhd
	ghdl -a --std=08 --work=riscpol_lib 				../../riscpol_pkg.vhd
	# Core
	ghdl -a --std=08 --work=alu_lib 					../../core/alu_design.vhd
	ghdl -a --std=08 --work=alu_mux_1_lib 				../../core/alu_mux_1_design.vhd
	ghdl -a --std=08 --work=alu_mux_2_lib 				../../core/alu_mux_2_design.vhd
	ghdl -a --std=08 --work=branch_instructions_lib 	../../core/branch_instructions_design.vhd
	ghdl -a --std=08 --work=control_lib 				../../core/control_design.vhd
	ghdl -a --std=08 --work=decoder_lib 				../../core/decoder_design.vhd
	ghdl -a --std=08 --work=instruction_memory_lib 		../../core/rom.vhd
	ghdl -a --std=08 --work=instruction_memory_lib 		../../core/instruction_memory_design.vhd
	ghdl -a --std=08 --work=program_counter_lib 		../../core/program_counter_design.vhd
	ghdl -a --std=08 --work=ram_management_lib 			../../core/ram_management_design.vhd
	ghdl -a --std=08 --work=reg_file_lib 				../../core/register_file_design.vhd
	ghdl -a --std=08 --work=core_lib 				../../core/core_design.vhd
	# Peripherals
	ghdl -a --std=08 --work=gpio_lib 				../../peripherals/gpio_design.vhd
	ghdl -a --std=08 --work=ram_lib 				../../peripherals/ram.vhd
	# Design
	ghdl -a --std=08 --work=riscpol_lib 				../../riscpol_design.vhd
	# Test
	#ghdl -a --std=08 --work=riscpol_lib 				../../riscpol_pkg.vhd

run_test_and__generate_waves:


display_waveforms:

