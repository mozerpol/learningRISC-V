all: clean analyze run_test_and_generate_waves display_waveforms

clean:
	rm -f *.cf

analyze:
	# Packages
	ghdl -a --std=08 --work=control_lib             ../../core/control_pkg.vhdl
	ghdl -a --std=08 --work=opcodes                 ../../core/opcodes.vhdl
	ghdl -a --std=08 --work=riscpol_lib             ../../riscpol_pkg.vhdl
	# Core
	ghdl -a --std=08 --work=alu_lib                 ../../core/alu_design.vhdl
	ghdl -a --std=08 --work=alu_mux_1_lib           ../../core/alu_mux_1_design.vhdl
	ghdl -a --std=08 --work=alu_mux_2_lib           ../../core/alu_mux_2_design.vhdl
	ghdl -a --std=08 --work=branch_instructions_lib ../../core/branch_instructions_design.vhdl
	ghdl -a --std=08 --work=control_lib             ../../core/control_design.vhdl
	ghdl -a --std=08 --work=decoder_lib             ../../core/decoder_design.vhdl
	ghdl -a --std=08 --work=instruction_memory_lib  ../../core/rom.vhdl
	ghdl -a --std=08 --work=instruction_memory_lib  ../../core/instruction_memory_design.vhdl
	ghdl -a --std=08 --work=program_counter_lib     ../../core/program_counter_design.vhdl
	ghdl -a --std=08 --work=ram_management_lib      ../../core/ram_management_design.vhdl
	ghdl -a --std=08 --work=register_file_lib       ../../core/register_file_design.vhdl
	ghdl -a --std=08 --work=core_lib                ../../core/core_design.vhdl
	# Peripherals
	ghdl -a --std=08 --work=gpio_lib                ../../peripherals/gpio_design.vhdl
	ghdl -a --std=08 --work=ram_lib                 ../../peripherals/ram.vhdl
	# Design
	ghdl -a --std=08 --work=riscpol_lib             ../../riscpol_design.vhdl
	# Test
	ghdl -a --std=08 --work=riscpol_lib             ../../riscpol_tb.vhdl

run_test_and_generate_waves:
	ghdl -r -frelaxed --syn-binding --std=08 --work=riscpol_lib riscpol_tb --wave=wave.ghw

display_waveforms:
	gtkwave wave.ghw --script=waveforms.tcl
