--------------------------------------------------------------------------------
-- File          : rom.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : This file must contain the instructions to be executed by the
-- processor. Instructions from e.g. assembly language can be translated into 
-- machine code using online compilers (e.g. risc-v venus). On each rising edge 
-- of the clock signal (i_clk), the appropriate instruction (indicated by 
-- i_instruction_addr) is passed to the decoder - this happens in the 
-- instruction_memory module.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.std_logic_unsigned.all;
library mozerpol_lib;
   use mozerpol_lib.mozerpol_pkg.all;

package rom is


   type t_rom  is array (0 to C_ROM_LENGTH-1) of std_logic_vector(31 downto 0);

   -- Instructions can be pasted here manually, or more easily using the
   -- rom_updater.py script. To do this paste the hex code into the code.txt file
   -- and run the rom_updater.py script, which will automatically paste the code
   -- into the rom.vhd file.
   -- If there are more than 1024 lines of code, be sure to change the value of
   -- the C_ROM_LENGTH constant in the mozerpol_pkg.vhd file. The value must be
   -- greater than or equal to the number of lines of code.
   constant C_CODE : t_rom := (
      x"123450b7",
      x"67808093",
      x"00104863",
      x"fff03193",
      x"00000217",
      x"00c002ef",
      x"00000117",
      x"fe0008e3",
      x"0021c333",
      x"0060f3b3",
      x"0003a433",
      x"0012b4b3",
      x"40300533",
      x"4013d593",
      x"00102223",
      x"00101023",
      x"0e900fa3",
      x"0ea00fa3",
      x"00001603",
      x"00500683",
      x"00000717",
      others => x"00000000"
      );
end;

package body rom is

end package body;
