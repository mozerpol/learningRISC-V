library ieee;
 use ieee.std_logic_1164.all;
 use IEEE.std_logic_unsigned.all;
 use IEEE.math_real.all;
 
package ram_management_pkg is

   -- constant C_NAME : std_logic_vector(N downto M) := "X";
   constant C_READ_ENABLE       : std_logic := '0'; 
   constant C_WRITE_ENABLE       : std_logic := '1'; 
   constant C_LB       : std_logic_vector(2 downto 0) := "000";
   constant C_LH       : std_logic_vector(2 downto 0) := "001";
   constant C_LW       : std_logic_vector(2 downto 0) := "010";
   constant C_LBU      : std_logic_vector(2 downto 0) := "011";
   constant C_LHU      : std_logic_vector(2 downto 0) := "100";
   constant C_SB       : std_logic_vector(2 downto 0) := "101";
   constant C_SH       : std_logic_vector(2 downto 0) := "110";
   constant C_SW       : std_logic_vector(2 downto 0) := "111";
   
end;

package body ram_management_pkg is
   
end package body;
