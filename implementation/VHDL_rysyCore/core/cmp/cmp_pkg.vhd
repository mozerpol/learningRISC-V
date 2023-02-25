library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package cmp_pkg is
    -- constant C_NAME : std_logic_vector(N downto M) := "X";
    constant EQ   : std_logic_vector(2 downto 0) := "000";
    constant NE   : std_logic_vector(2 downto 0) := "001";
    constant LT   : std_logic_vector(2 downto 0) := "010";
    constant GE   : std_logic_vector(2 downto 0) := "011";
    constant LTU  : std_logic_vector(2 downto 0) := "100";
    constant GEU  : std_logic_vector(2 downto 0) := "101";
    
 end;
 
 package body cmp_pkg is
 
 end package body;
