library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;

 package control_pkg is

   -- alu
   constant C_LUI      : std_logic_vector(4 downto 0) := "00000";
   constant C_AUIPC    : std_logic_vector(4 downto 0) := "00001";
   constant C_JAL      : std_logic_vector(4 downto 0) := "00010";
   constant C_JALR     : std_logic_vector(4 downto 0) := "00011";
   constant C_ADDI     : std_logic_vector(4 downto 0) := "00100";
   constant C_SLTI     : std_logic_vector(4 downto 0) := "00101";
   constant C_SLTIU    : std_logic_vector(4 downto 0) := "00110";
   constant C_XORI     : std_logic_vector(4 downto 0) := "00111";
   constant C_ORI      : std_logic_vector(4 downto 0) := "01000";
   constant C_ANDI     : std_logic_vector(4 downto 0) := "01001";
   constant C_SLLI     : std_logic_vector(4 downto 0) := "01010";
   constant C_SRLI     : std_logic_vector(4 downto 0) := "01011";
   constant C_SRAI     : std_logic_vector(4 downto 0) := "01100";
   constant C_ADD      : std_logic_vector(4 downto 0) := "01101";
   constant C_SUB      : std_logic_vector(4 downto 0) := "01110";
   constant C_SLL      : std_logic_vector(4 downto 0) := "01111";
   constant C_SLT      : std_logic_vector(4 downto 0) := "10000";
   constant C_SLTU     : std_logic_vector(4 downto 0) := "10001";
   constant C_XOR      : std_logic_vector(4 downto 0) := "10010";
   constant C_SRL      : std_logic_vector(4 downto 0) := "10011";
   constant C_SRA      : std_logic_vector(4 downto 0) := "10100";
   constant C_OR       : std_logic_vector(4 downto 0) := "10101";
   constant C_AND      : std_logic_vector(4 downto 0) := "10110";
   constant C_FENCE    : std_logic_vector(4 downto 0) := "10111";
   constant C_FENCE_I  : std_logic_vector(4 downto 0) := "11000";
   constant C_ECALL    : std_logic_vector(4 downto 0) := "11001";
   constant C_EBREAK   : std_logic_vector(4 downto 0) := "11010";
   constant C_CSRRW    : std_logic_vector(4 downto 0) := "11011";
   constant C_CSRRS    : std_logic_vector(4 downto 0) := "11100";
   constant C_CSRRC    : std_logic_vector(4 downto 0) := "11101";
   constant C_CSRRWI   : std_logic_vector(4 downto 0) := "11110";
   constant C_PASS_IMM : std_logic_vector(4 downto 0) := "11111";
   -- constant C_CSRRSI   : std_logic_vector(4 downto 0) := "000000";
   -- constant C_CSRRCI   : std_logic_vector(4 downto 0) := "000000";
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
   constant C_TAKEN : std_logic := '1';
   constant C_BEQ                : std_logic_vector(2 downto 0) := "000";
   constant C_BNE                : std_logic_vector(2 downto 0) := "001";
   constant C_BLT                : std_logic_vector(2 downto 0) := "010";
   constant C_BGE                : std_logic_vector(2 downto 0) := "011";
   constant C_BLTU               : std_logic_vector(2 downto 0) := "100";
   constant C_BGEU               : std_logic_vector(2 downto 0) := "101";
 end;

 package body control_pkg is

 end package body;
