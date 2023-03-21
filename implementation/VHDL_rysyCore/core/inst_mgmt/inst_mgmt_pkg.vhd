library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package inst_mgmt_pkg is
    -- constant C_NAME : std_logic_vector(N downto M) := "X";
    constant C_NOP      : std_logic_vector(31 downto 0) := 32x"00000013";
    constant INST_OLD   : std_logic_vector(1 downto 0)  := "00";
    constant INST_NOP   : std_logic_vector(1 downto 0)  := "01"; 
    constant INST_MEM   : std_logic_vector(1 downto 0)  := "10";
 end;
 
 package body inst_mgmt_pkg is
 
 end package body;
