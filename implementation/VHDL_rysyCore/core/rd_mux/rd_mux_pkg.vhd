library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package rd_mux_pkg is
    -- constant C_NAME : std_logic_vector(N downto M) := "X";
    constant RD_IMM  : std_logic_vector(1 downto 0) := "00";
    constant RD_PCP4 : std_logic_vector(1 downto 0) := "01";
    constant RD_ALU  : std_logic_vector(1 downto 0) := "10";
    constant RD_MEM  : std_logic_vector(1 downto 0) := "11";
 end;
 
 package body rd_mux_pkg is
 
 end package body;
