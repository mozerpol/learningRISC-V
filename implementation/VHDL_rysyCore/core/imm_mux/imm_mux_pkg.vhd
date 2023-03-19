library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;

 package imm_mux_pkg is
    -- constant C_NAME : std_logic_vector(N downto M) := "X";
   constant C_IMM_J : std_logic_vector(2 downto 0) := "000";
   constant C_IMM_U : std_logic_vector(2 downto 0) := "001";
   constant C_IMM_B : std_logic_vector(2 downto 0) := "010";
   constant C_IMM_S : std_logic_vector(2 downto 0) := "011";
   constant C_IMM_I : std_logic_vector(2 downto 0) := "100";
   constant C_IMM_DEFAULT : std_logic_vector(2 downto 0) := "101";
 end;

 package body imm_mux_pkg is

 end package body;
