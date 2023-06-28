library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package control_pkg is
    -- constant C_NAME : std_logic_vector(N downto M) := "X";
   -- Opcodes, all are in documentation in table on page 104
   ---- U-type ----
   constant C_OPCODE_LUI      : std_logic_vector(4 downto 0) := "01101";
   constant C_OPCODE_AUIPC    : std_logic_vector(4 downto 0) := "00101";
   ---- J-type ----
   constant C_OPCODE_JAL      : std_logic_vector(4 downto 0) := "11011";
   ---- I-type ----
   constant C_OPCODE_JALR     : std_logic_vector(4 downto 0) := "11001";
   -- C_OPCODE_LOAD = LB, LH, LW, LBU, LHU, LD, LWU
   constant C_OPCODE_LOAD     : std_logic_vector(4 downto 0) := "00000";
   -- OP_IMM = ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, SLLI, SRLI,
   -- SRAI
   constant C_OPCODE_OPIMM    : std_logic_vector(4 downto 0) := "00100";
   ---- B-type ----
   -- C_OPCODE_BRANCH = BEQ, BNE, BLT, BGE, BLTU, BGEU
   constant C_OPCODE_BRANCH   : std_logic_vector(4 downto 0) := "11000";
   ---- S-type ----
   -- C_OPCODE_STORE = SB, SH, SW, SD
   constant C_OPCODE_STORE    : std_logic_vector(4 downto 0) := "01000";
   ---- R-type ----
   -- C_OPCODE_OP = ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
   constant C_OPCODE_OP       : std_logic_vector(4 downto 0) := "01100";
   
 end;
 
 package body control_pkg is
 
 end package body;
