library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;

package opcodesPkg is
   --''''''''''''--
   --   opcode   --
   --,,,,,,,,,,,,--
   -- constant C_NAME : std_logic_vector(N downto M) := "X";
   constant LOAD        : std_logic_vector(4 downto 0) := "00000";
   constant LOAD_FP     : std_logic_vector(4 downto 0) := "00001";
   constant CUSTOM_0    : std_logic_vector(4 downto 0) := "00010";
   constant MISC_MEM    : std_logic_vector(4 downto 0) := "00011";
   constant OP_IMM      : std_logic_vector(4 downto 0) := "00100";
   constant AUIPC       : std_logic_vector(4 downto 0) := "00101";
   constant OP_IMM_32   : std_logic_vector(4 downto 0) := "00110";
   constant LEN_48_0    : std_logic_vector(4 downto 0) := "00111";
   constant STORE       : std_logic_vector(4 downto 0) := "01000";
   constant STORE_FP    : std_logic_vector(4 downto 0) := "01001";
   constant CUSTOM_1    : std_logic_vector(4 downto 0) := "01010";
   constant AMO  	      : std_logic_vector(4 downto 0) := "01011";
   constant OP		      : std_logic_vector(4 downto 0) := "01100";
   constant LUI 	      : std_logic_vector(4 downto 0) := "01101";
   constant OP_32       : std_logic_vector(4 downto 0) := "01110";
   constant LEN_64      : std_logic_vector(4 downto 0) := "01111";
   constant MADD 	      : std_logic_vector(4 downto 0) := "10000";
   constant MSUB 	      : std_logic_vector(4 downto 0) := "10001";
   constant NMSUB       : std_logic_vector(4 downto 0) := "10010";
   constant NMADD       : std_logic_vector(4 downto 0) := "10011";
   constant OP_FP       : std_logic_vector(4 downto 0) := "10100";
   constant RESERVED_0  : std_logic_vector(4 downto 0) := "10101";
   constant CUSTOM_2    : std_logic_vector(4 downto 0) := "10110";
   constant LEN_48_1    : std_logic_vector(4 downto 0) := "10111";
   constant BRANCH 	   : std_logic_vector(4 downto 0) := "11000";
   constant JALR 	      : std_logic_vector(4 downto 0) := "11001";
   constant RESERVED_1  : std_logic_vector(4 downto 0) := "11010";
   constant JAL         : std_logic_vector(4 downto 0) := "11011";
   constant SYSTEM      : std_logic_vector(4 downto 0) := "11100";
   constant RESERVED_2  : std_logic_vector(4 downto 0) := "11101";
   constant CUSTOM_3    : std_logic_vector(4 downto 0) := "11110";
   constant LEN_80 	   : std_logic_vector(4 downto 0) := "11111";

   --''''''''''''''''''--
   --  FUNC3_BRANCH    --
   --,,,,,,,,,,,,,,,,,,--
   constant FUNC3_BRANCH_BEQ  : std_logic_vector(2 downto 0) := "000";
   constant FUNC3_BRANCH_BNE  : std_logic_vector(2 downto 0) := "001";
   constant FUNC3_BRANCH_BLT  : std_logic_vector(2 downto 0) := "100";
   constant FUNC3_BRANCH_BGE  : std_logic_vector(2 downto 0) := "101";
   constant FUNC3_BRANCH_BLTU : std_logic_vector(2 downto 0) := "110";
   constant FUNC3_BRANCH_BGEU : std_logic_vector(2 downto 0) := "111";

   --''''''''''''''''''''''--
   --   FUNC3_LOAD_STORE   --
   --,,,,,,,,,,,,,,,,,,,,,,--
   constant FUNC3_SB    : std_logic_vector(2 downto 0) := "000"; 
   constant FUNC3_SH    : std_logic_vector(2 downto 0) := "001"; 
   constant FUNC3_SW    : std_logic_vector(2 downto 0) := "010"; 
   constant FUNC3_SBU   : std_logic_vector(2 downto 0) := "100"; 
   constant FUNC3_SHU   : std_logic_vector(2 downto 0) := "101";

   --''''''''''''''''''--
   --   FUNC3_OP_IMM   --
   --,,,,,,,,,,,,,,,,,,--
   constant FUNC3_ADD_SUB  : std_logic_vector(2 downto 0) := "000";
   constant FUNC3_SLT      : std_logic_vector(2 downto 0) := "010";
   constant FUNC3_SLTU     : std_logic_vector(2 downto 0) := "011";
   constant FUNC3_XOR      : std_logic_vector(2 downto 0) := "100";
   constant FUNC3_OR       : std_logic_vector(2 downto 0) := "110";
   constant FUNC3_AND      : std_logic_vector(2 downto 0) := "111";
   constant FUNC3_SLL      : std_logic_vector(2 downto 0) := "001";
   constant FUNC3_SR       : std_logic_vector(2 downto 0) := "101";

   --''''''''''''''--
   --   FUNC7_SR   --
   --,,,,,,,,,,,,,,--
   constant FUNC7_SR_SRL   : std_logic_vector(6 downto 0) := "0000000";
   constant FUNC7_SR_SRA	: std_logic_vector(6 downto 0) := "0100000";

   --''''''''''''''''''''''--
   --   FUNC7_OP_ADD_SUB   --
   --,,,,,,,,,,,,,,,,,,,,,,--
   constant FUNC7_ADD_SUB_ADD : std_logic_vector(6 downto 0) := "0000000";
   constant FUNC7_ADD_SUB_SUB	: std_logic_vector(6 downto 0) := "0100000";

   --''''''''''''''''''''--
   --   FUNC3_MISC_MEM   --
   --,,,,,,,,,,,,,,,,,,,,--
   constant FUNC3_MISC_MEM_FENCE	: std_logic_vector(2 downto 0) := "000";

   --'''''''''''''''''''--
   --   FUNC25_SYSTEM   --
   --,,,,,,,,,,,,,,,,,,,--
   constant FUNC_SYSTEM_ECALL	   : std_logic_vector(24 downto 0) := (others => '0');
   constant FUNC_SYSTEM_EBREAK 	: std_logic_vector(24 downto 0) := 24x"002000";
end;

package body opcodesPkg is
end package body;
