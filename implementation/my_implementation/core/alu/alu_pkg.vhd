library ieee;
 use ieee.std_logic_1164.all;
 use IEEE.std_logic_unsigned.all;
 use IEEE.math_real.all;
 
package alu_pkg is

   -- constant C_NAME : std_logic_vector(N downto M) := "X";
   constant C_LUI      : std_logic_vector(5 downto 0) := "000000";
   constant C_AUIPC    : std_logic_vector(5 downto 0) := "000001";
   constant C_JAL      : std_logic_vector(5 downto 0) := "000010";
   constant C_JALR     : std_logic_vector(5 downto 0) := "000011";
   constant C_BEQ      : std_logic_vector(5 downto 0) := "000100";
   constant C_BNE      : std_logic_vector(5 downto 0) := "000101";
   constant C_BLT      : std_logic_vector(5 downto 0) := "000110";
   constant C_BGE      : std_logic_vector(5 downto 0) := "000111";
   constant C_BLTU     : std_logic_vector(5 downto 0) := "001000";
   constant C_BGEU     : std_logic_vector(5 downto 0) := "001001";
   constant C_ADDI     : std_logic_vector(5 downto 0) := "010010";
   constant C_SLTI     : std_logic_vector(5 downto 0) := "010011";
   constant C_SLTIU    : std_logic_vector(5 downto 0) := "010100";
   constant C_XORI     : std_logic_vector(5 downto 0) := "010101";
   constant C_ORI      : std_logic_vector(5 downto 0) := "010110";
   constant C_ANDI     : std_logic_vector(5 downto 0) := "010111";
   constant C_SLLI     : std_logic_vector(5 downto 0) := "011000";
   constant C_SRLI     : std_logic_vector(5 downto 0) := "011001";
   constant C_SRAI     : std_logic_vector(5 downto 0) := "011010";
   constant C_ADD      : std_logic_vector(5 downto 0) := "011011";
   constant C_SUB      : std_logic_vector(5 downto 0) := "011100";
   constant C_SLL      : std_logic_vector(5 downto 0) := "011101";
   constant C_SLT      : std_logic_vector(5 downto 0) := "011110";
   constant C_SLTU     : std_logic_vector(5 downto 0) := "011111";
   constant C_XOR      : std_logic_vector(5 downto 0) := "100000";
   constant C_SRL      : std_logic_vector(5 downto 0) := "100001";
   constant C_SRA      : std_logic_vector(5 downto 0) := "100010";
   constant C_OR       : std_logic_vector(5 downto 0) := "100011";
   constant C_AND      : std_logic_vector(5 downto 0) := "100100";
   constant C_FENCE    : std_logic_vector(5 downto 0) := "100101";
   constant C_FENCE_I  : std_logic_vector(5 downto 0) := "100110";
   constant C_ECALL    : std_logic_vector(5 downto 0) := "100111";
   constant C_EBREAK   : std_logic_vector(5 downto 0) := "101000";
   constant C_CSRRW    : std_logic_vector(5 downto 0) := "101001";
   constant C_CSRRS    : std_logic_vector(5 downto 0) := "101010";
   constant C_CSRRC    : std_logic_vector(5 downto 0) := "101011";
   constant C_CSRRWI   : std_logic_vector(5 downto 0) := "101100";
   constant C_CSRRSI   : std_logic_vector(5 downto 0) := "101101";
   constant C_CSRRCI   : std_logic_vector(5 downto 0) := "101110";
   
end;

package body alu_pkg is
   
end package body;
