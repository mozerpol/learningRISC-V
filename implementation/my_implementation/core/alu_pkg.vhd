library ieee;
   use ieee.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use IEEE.math_real.all;

package alu_pkg is

   -- constant C_NAME : std_logic_vector(N downto M) := "X";
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

end;

package body alu_pkg is

end package body;
