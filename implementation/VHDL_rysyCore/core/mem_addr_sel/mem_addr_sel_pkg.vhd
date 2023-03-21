library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package mem_addr_sel_pkg is
    -- constant C_NAME : std_logic_vector(N downto M) := "X";
    constant PC_ALU     : std_logic_vector(1 downto 0) := "00";
    constant PC_P4      : std_logic_vector(1 downto 0) := "01";
    constant PC_M4      : std_logic_vector(1 downto 0) := "10";
    constant PC_OLD     : std_logic_vector(1 downto 0) := "11";
    constant MEM_PC     : std_logic                    := '0';
    constant MEM_ALU    : std_logic                    := '1';
   
 end;
 
 package body mem_addr_sel_pkg is
 
 end package body;
