library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package select_rd_pkg is
   -- SB, SH, ... are S-type instructions, storage instructions.
   constant SB     : std_logic_vector(2 downto 0) := "000";
   constant SH     : std_logic_vector(2 downto 0) := "001";
   constant SW     : std_logic_vector(2 downto 0) := "010";
   constant SBU    : std_logic_vector(2 downto 0) := "011";
   constant SHU    : std_logic_vector(2 downto 0) := "100";
 end;
 
 package body select_rd_pkg is
 
 end package body;
