# Requirements: installed python and files code.txt, rom.vhd in the same directory with rom_updater.py
# How to run: python3 rom_updater.py

# Open the code.txt file
with open("code.txt", "r") as file:
    # Read the contents of the file
    code_data = file.readlines()

# Open the rom.vhd file
with open("rom.vhd", "w") as file:
    # Write the initial lines of the rom.vhd file
    file.write('library ieee;\n')
    file.write('    use ieee.std_logic_1164.all;\n')
    file.write('    use IEEE.std_logic_unsigned.all;\n')
    file.write('library riscpol_lib;\n')
    file.write('   use riscpol_lib.riscpol_pkg.all;\n\n')
    file.write('package rom is\n\n\n')
    file.write('   type t_rom  is array (0 to C_ROM_LENGTH-1) of std_logic_vector(31 downto 0);\n\n')
    file.write('   constant C_CODE : t_rom := (\n')

    # Write the content of the code.txt file into the rom.vhd file
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
value of the C_ROM_LENGTH constant in the riscpol_pkg.vhd file. The value must\n\
be greater than or equal to the number of lines of code.\n\n")
