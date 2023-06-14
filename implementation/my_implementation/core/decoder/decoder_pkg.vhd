library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package decoder_pkg is

   -- Opcodes
   constant C_OPCODE_LOAD     : std_logic_vector(4 downto 0) := "00000";
   constant C_OPCODE_STORE    : std_logic_vector(4 downto 0) := "01000";
   constant C_OPCODE_MADD     : std_logic_vector(4 downto 0) := "10000";
   constant C_OPCODE_BRANCH   : std_logic_vector(4 downto 0) := "11000";
   constant C_OPCODE_JALR     : std_logic_vector(4 downto 0) := "11001";
   constant C_OPCODE_JAL      : std_logic_vector(4 downto 0) := "11011";
   constant C_OPCODE_SYSTEM   : std_logic_vector(4 downto 0) := "11100";
   constant C_OPCODE_OP       : std_logic_vector(4 downto 0) := "01100";
   constant C_OPCODE_OPIMM    : std_logic_vector(4 downto 0) := "00100";
   constant C_OPCODE_MISCMEM  : std_logic_vector(4 downto 0) := "00011";
   constant C_OPCODE_AUIPC    : std_logic_vector(4 downto 0) := "00101";
   constant C_OPCODE_LUI      : std_logic_vector(4 downto 0) := "01101";

 end;
 -- https://github.com/Domipheus/RPU
 package body decoder_pkg is
 
 end package body;
