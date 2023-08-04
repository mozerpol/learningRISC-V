library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;

package opcodesPkg is
   -- All opcodes are in the documentation in the table on page 104
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

   --''''''''''''''''''''''--
   --      FUNC3 LOAD      --
   --,,,,,,,,,,,,,,,,,,,,,,--
   constant C_FUNC3_LB        : std_logic_vector(2 downto 0) := "000";
   constant C_FUNC3_LH        : std_logic_vector(2 downto 0) := "001";
   constant C_FUNC3_LW        : std_logic_vector(2 downto 0) := "010";
   constant C_FUNC3_LBU       : std_logic_vector(2 downto 0) := "100";
   constant C_FUNC3_LHU       : std_logic_vector(2 downto 0) := "101";

   --''''''''''''''''''--
   --   FUNC3 OP_IMM   --
   --,,,,,,,,,,,,,,,,,,--
   constant C_FUNC3_ADDI      : std_logic_vector(2 downto 0) := "000";
   constant C_FUNC3_SLTI      : std_logic_vector(2 downto 0) := "010";
   constant C_FUNC3_SLTIU     : std_logic_vector(2 downto 0) := "011";
   constant C_FUNC3_XORI      : std_logic_vector(2 downto 0) := "100";
   constant C_FUNC3_ORI       : std_logic_vector(2 downto 0) := "110";
   constant C_FUNC3_ANDI      : std_logic_vector(2 downto 0) := "111";
   constant C_FUNC3_SLLI      : std_logic_vector(2 downto 0) := "001";
   constant C_FUNC3_SRLI_SRAI : std_logic_vector(2 downto 0) := "101";

   --''''''''''''''''''--
   --   FUNC7 OP_IMM   --
   --,,,,,,,,,,,,,,,,,,--
   constant C_FUNC7_SRLI      : std_logic_vector(6 downto 0) := "0000000";
   constant C_FUNC7_SRAI      : std_logic_vector(6 downto 0) := "0100000";
   constant C_FUNC7_SLLI      : std_logic_vector(6 downto 0) := "0000000";

   --''''''''''''''''''--
   --     FUNC3 OP     --
   --,,,,,,,,,,,,,,,,,,--
   constant C_FUNC3_ADD_SUB   : std_logic_vector(2 downto 0) := "000";
   constant C_FUNC3_SLL       : std_logic_vector(2 downto 0) := "001";
   constant C_FUNC3_SLT       : std_logic_vector(2 downto 0) := "010";
   constant C_FUNC3_SLTU      : std_logic_vector(2 downto 0) := "011";
   constant C_FUNC3_XOR       : std_logic_vector(2 downto 0) := "100";
   constant C_FUNC3_SRL_SRA   : std_logic_vector(2 downto 0) := "101";
   constant C_FUNC3_OR        : std_logic_vector(2 downto 0) := "110";
   constant C_FUNC3_AND       : std_logic_vector(2 downto 0) := "111";

   --''''''''''''''''''--
   --     FUNC7 OP     --
   --,,,,,,,,,,,,,,,,,,--
   constant C_FUNC7_SUB       : std_logic_vector(6 downto 0) := "0100000";
   constant C_FUNC7_ADD       : std_logic_vector(6 downto 0) := "0000000";
   constant C_FUNC7_SRA       : std_logic_vector(6 downto 0) := "0100000";
   constant C_FUNC7_SRL       : std_logic_vector(6 downto 0) := "0000000";

   --''''''''''''''''''--
   --  FUNC3 BRANCH    --
   --,,,,,,,,,,,,,,,,,,--
   constant C_FUNC3_BEQ       : std_logic_vector(2 downto 0) := "000";
   constant C_FUNC3_BNE       : std_logic_vector(2 downto 0) := "001";
   constant C_FUNC3_BLT       : std_logic_vector(2 downto 0) := "100";
   constant C_FUNC3_BGE       : std_logic_vector(2 downto 0) := "101";
   constant C_FUNC3_BLTU      : std_logic_vector(2 downto 0) := "110";
   constant C_FUNC3_BGEU      : std_logic_vector(2 downto 0) := "111";

   --''''''''''''''''''''''--
   --     FUNC3 STORE      --
   --,,,,,,,,,,,,,,,,,,,,,,--
   constant C_FUNC3_SB        : std_logic_vector(2 downto 0) := "000";
   constant C_FUNC3_SH        : std_logic_vector(2 downto 0) := "001";
   constant C_FUNC3_SW        : std_logic_vector(2 downto 0) := "010";

end;

package body opcodesPkg is
end package body;
