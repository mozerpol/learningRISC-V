# Requirements: installed python and files code.txt, rom.vhdl in the same directory with rom_updater.py
# How to run: python3 rom_updater.py
# In code.txt paste instructions to be executed

# Open the code.txt file
with open("code.txt", "r") as file:
    # Read the contents of the file
    code_data = file.readlines()

# Open the rom.vhdl file
with open("rom.vhdl", "w") as file:
    # Write the initial lines of the rom.vhdl file
    file.write('--------------------------------------------------------------------------------\n')
    file.write('-- File          : rom.vhdl\n')
    file.write('-- Author        : mozerpol\n')
    file.write('--------------------------------------------------------------------------------\n')
    file.write('-- Description   : This file contains instructions to be executed. They can be\n')
    file.write('-- manually added/edited in an analogous way as shown here by modifying C_CODE\n')
    file.write('-- array. In a situation where are a lot of instructions, you can paste them\n')
    file.write('-- into the code.txt file, and then run a script which is written in python,\n')
    file.write('-- which will paste all instructions into this file by executing the command:\n')
    file.write('-- python3 rom_updater.py\n')
    file.write('-- There are two important rules:\n')
    file.write('-- 1. The last instruction in the C_CODE array must be: others => x"00000000"\n')
    file.write('-- 2. The size of the instruction memory is set in the riscpol_pkg.vhdl file as a\n')
    file.write('-- C_ROM_LENGTH constant.\n')
    file.write('--------------------------------------------------------------------------------\n')
    file.write('-- License       : MIT 2022 mozerpol\n')
    file.write('--------------------------------------------------------------------------------\n\n')
    file.write('library ieee;\n')
    file.write('    use ieee.std_logic_1164.all;\n')
    file.write('    use IEEE.std_logic_unsigned.all;\n')
    file.write('library riscpol_lib;\n')
    file.write('   use riscpol_lib.riscpol_pkg.all;\n\n')
    file.write('package rom is\n\n\n')
    file.write('   type t_rom  is array (0 to C_ROM_LENGTH-1) of std_logic_vector(31 downto 0);\n\n')
    file.write('   constant C_CODE : t_rom := (\n')

    # Write the content of the code.txt file into the rom.vhdl file
    for line in code_data:
        file.write(f'      x"{line.strip()}",\n')

    # Write the last line and close the file
    file.write('      others => x"00000000"\n')
    file.write('      );\n')
    file.write('end;\n\n')
    file.write('package body rom is\n\n')
    file.write('end package body;\n')

# Message
print("\n\nIf there are more than 1024 lines of code, be sure to change the\n\
value of the C_ROM_LENGTH constant in the riscpol_pkg.vhdl file. The value must\n\
be greater than or equal to the number of lines of code.\n\n")
