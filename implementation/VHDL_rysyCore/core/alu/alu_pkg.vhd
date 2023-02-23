library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package alu_pkg is
    -- constant C_NAME : std_logic_vector(N downto M) := "X";
    constant ADD  : std_logic_vector(3 downto 0) := "0000";
    -- constant SUB  : std_logic_vector(3 downto 0) := "0001";
    -- constant XOR : std_logic_vector(3 downto 0) := "0010";
    -- constant OR : std_logic_vector(3 downto 0) :=  "0011";
    -- constant AND : std_logic_vector(3 downto 0) := "0100";
    -- constant SLL : std_logic_vector(3 downto 0) := "0101";
    -- constant SRL : std_logic_vector(3 downto 0) := "0110";
    -- constant SRA : std_logic_vector(3 downto 0) := "0111";
    constant SLT  : std_logic_vector(3 downto 0) := "1000";
    constant SLTU : std_logic_vector(3 downto 0) :="1001";

 end;
 
 package body alu_pkg is
 
 end package body;
