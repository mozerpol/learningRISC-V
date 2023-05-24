library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;

package selectPkg is
   -- SB, SH, ... are S-type instructions, storage instructions.
   constant SB     : std_logic_vector(2 downto 0) := "000";
   constant SH     : std_logic_vector(2 downto 0) := "001";
   constant SW     : std_logic_vector(2 downto 0) := "010";
   constant SBU    : std_logic_vector(2 downto 0) := "011";
   constant SHU    : std_logic_vector(2 downto 0) := "100";
end;

package body selectPkg is

end package body;
