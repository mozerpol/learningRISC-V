library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;

package program_counter_pkg is

   constant C_INCREMENT_PC    : std_logic_vector(1 downto 0) := "00";
   constant C_DECREMENT_PC    : std_logic_vector(1 downto 0) := "01";
   constant C_LOAD_ALU_RESULT : std_logic_vector(1 downto 0) := "10";
   constant C_NOP             : std_logic_vector(1 downto 0) := "11";
   constant C_INST_ADDR_PC    : std_logic := '0';
   constant C_INST_ADDR_ALU   : std_logic := '1';

end;

package body program_counter_pkg is

end package body;
