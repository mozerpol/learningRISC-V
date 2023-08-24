library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;

package branch_instructions_pkg is

   -- constant C_NAME : std_logic_vector(N downto M) := "X";
   constant C_BEQ    : std_logic_vector(2 downto 0) := "000";
   constant C_BNE    : std_logic_vector(2 downto 0) := "001";
   constant C_BLT    : std_logic_vector(2 downto 0) := "010";
   constant C_BGE    : std_logic_vector(2 downto 0) := "011";
   constant C_BLTU   : std_logic_vector(2 downto 0) := "100";
   constant C_BGEU   : std_logic_vector(2 downto 0) := "101";

end;

package body branch_instructions_pkg is

end package body;
