library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package control_pkg is
   -- Opcodes, all are in documentation in table on page 104
   ---- U-type ----
   constant C_OPCODE_LUI      : std_logic_vector(4 downto 0) := "01101";
   constant C_OPCODE_AUIPC    : std_logic_vector(4 downto 0) := "00101";
   ---- J-type ----
   constant C_OPCODE_JAL      : std_logic_vector(4 downto 0) := "11011";
   ---- I-type ----
   constant C_OPCODE_JALR     : std_logic_vector(4 downto 0) := "11001";
   -- C_OPCODE_LOAD   
   constant C_OPCODE_LOAD     : std_logic_vector(4 downto 0) := "00000";
   constant C_FUNC3_LB        : std_logic_vector(2 downto 0) := "000";
   constant C_FUNC3_LH        : std_logic_vector(2 downto 0) := "001";
   constant C_FUNC3_LW        : std_logic_vector(2 downto 0) := "010";
   constant C_FUNC3_LBU       : std_logic_vector(2 downto 0) := "100";
   constant C_FUNC3_LHU       : std_logic_vector(2 downto 0) := "101";
   -- OP_IMM
   constant C_OPCODE_OPIMM    : std_logic_vector(4 downto 0) := "00100";
   constant C_FUNC3_ADDI      : std_logic_vector(2 downto 0) := "000";
   constant C_FUNC3_SLTI      : std_logic_vector(2 downto 0) := "010";
   constant C_FUNC3_SLTIU     : std_logic_vector(2 downto 0) := "011";
   constant C_FUNC3_XORI      : std_logic_vector(2 downto 0) := "100";
   constant C_FUNC3_ORI       : std_logic_vector(2 downto 0) := "110";
   constant C_FUNC3_ANDI      : std_logic_vector(2 downto 0) := "111";
   constant C_FUNC3_SLLI      : std_logic_vector(2 downto 0) := "001";
   constant C_FUNC3_SRLI      : std_logic_vector(2 downto 0) := "101";
   constant C_FUNC3_SRAI      : std_logic_vector(2 downto 0) := "101";
   constant C_FUNC7_SRLI      : std_logic_vector(6 downto 0) := "0000000";
   constant C_FUNC7_SLLI      : std_logic_vector(6 downto 0) := "0000000";
   constant C_FUNC7_SRAI      : std_logic_vector(6 downto 0) := "0100000";
   ---- B-type ----
   -- C_OPCODE_BRANCH = BEQ, BNE, BLT, BGE, BLTU, BGEU
   constant C_OPCODE_BRANCH   : std_logic_vector(4 downto 0) := "11000";
   ---- S-type ----
   -- C_OPCODE_STORE = SB, SH, SW, SD
   constant C_OPCODE_STORE    : std_logic_vector(4 downto 0) := "01000";
   ---- R-type ----
   -- C_OPCODE_OP
   constant C_OPCODE_OP       : std_logic_vector(4 downto 0) := "01100";
   constant C_FUNC3_ADD_SUB   : std_logic_vector(2 downto 0) := "000";
   constant C_FUNC3_SLL       : std_logic_vector(2 downto 0) := "001";
   constant C_FUNC3_SLT       : std_logic_vector(2 downto 0) := "010";
   constant C_FUNC3_SLTU      : std_logic_vector(2 downto 0) := "011";
   constant C_FUNC3_XOR       : std_logic_vector(2 downto 0) := "100";
   constant C_FUNC3_SRL_SRA   : std_logic_vector(2 downto 0) := "101";
   constant C_FUNC3_OR        : std_logic_vector(2 downto 0) := "110";
   constant C_FUNC3_AND       : std_logic_vector(2 downto 0) := "111";
   constant C_FUNC7_SUB       : std_logic_vector(6 downto 0) := "0100000";
   constant C_FUNC7_SRA       : std_logic_vector(6 downto 0) := "0100000";
   
 end;
 
 package body control_pkg is
 
 end package body;
