--------------------------------------------------------------------------------
-- File          : rom.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : This file contains instructions to be executed. They can be
-- manually added/edited in an analogous way as shown here by modifying C_CODE
-- array. In a situation where are a lot of instructions, you can paste them
-- into the code.txt file, and then run a script which is written in python,
-- which will paste all instructions into this file by executing the command:
-- python3 rom_updater.py
-- There are two important rules:
-- 1. The last instruction in the C_CODE array must be: others => x"00000000"
-- 2. The size of the instruction memory is set in the riscpol_pkg.vhdl file as a
-- C_ROM_LENGTH constant.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.std_logic_unsigned.all;
library riscpol_lib;
   use riscpol_lib.riscpol_pkg.all;

package rom is


   type t_rom  is array (0 to C_ROM_LENGTH-1) of std_logic_vector(31 downto 0);

   constant C_CODE : t_rom := (
      x"00000417",
      x"00000497",
      x"40848533",
      x"00000597",
      x"fffff617",
      x"40b606b3",
      x"00000717",
      x"00800797",
      x"40e78833",
      x"00000897",
      x"00001917",
      x"411909b3",
      x"00000837",
      x"fffff8b7",
      x"7ffff937",
      x"004009b7",
      x"00200a37",
      x"00200a37",
      x"00001ab7",
      x"00003ab7",
      others => x"00000000"
      );
end;

package body rom is

end package body;
