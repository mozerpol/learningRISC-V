library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;

 package control_pkg is

   -- mux1, mux2
   constant C_RS1_DATA           : std_logic := '0';
   constant C_PC_ADDR            : std_logic := '1';
   constant C_RS2_DATA           : std_logic := '0';
   constant C_IMM                : std_logic := '1';
   -- program counter
   constant C_INCREMENT_PC       : std_logic_vector(1 downto 0) := "00";
   constant C_DECREMENT_PC       : std_logic_vector(1 downto 0) := "01";
   constant C_LOAD_ALU_RESULT    : std_logic_vector(1 downto 0) := "10";
   constant C_NOP                : std_logic_vector(1 downto 0) := "11";
   constant C_INST_ADDR_PC       : std_logic := '0';
   constant C_INST_ADDR_ALU      : std_logic := '1';
   -- reg_file
   constant C_READ_ENABLE        : std_logic := '0';
   constant C_WRITE_ENABLE       : std_logic := '1';
   constant C_WRITE_RD_DATA      : std_logic_vector(1 downto 0) := "00";
   constant C_WRITE_PC_ADDR      : std_logic_vector(1 downto 0) := "01";
   constant C_WRITE_ALU_RESULT   : std_logic_vector(1 downto 0) := "10";
   -- memory_management
   constant C_LB                 : std_logic_vector(2 downto 0) := "000";
   constant C_LH                 : std_logic_vector(2 downto 0) := "001";
   constant C_LW                 : std_logic_vector(2 downto 0) := "010";
   constant C_LBU                : std_logic_vector(2 downto 0) := "011";
   constant C_LHU                : std_logic_vector(2 downto 0) := "100";
   constant C_SB                 : std_logic_vector(2 downto 0) := "101";
   constant C_SH                 : std_logic_vector(2 downto 0) := "110";
   constant C_SW                 : std_logic_vector(2 downto 0) := "111";
   -- branch_instructions
   constant C_BEQ                : std_logic_vector(2 downto 0) := "000";
   constant C_BNE                : std_logic_vector(2 downto 0) := "001";
   constant C_BLT                : std_logic_vector(2 downto 0) := "010";
   constant C_BGE                : std_logic_vector(2 downto 0) := "011";
   constant C_BLTU               : std_logic_vector(2 downto 0) := "100";
   constant C_BGEU               : std_logic_vector(2 downto 0) := "101";
 end;

 package body control_pkg is

 end package body;
