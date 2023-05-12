library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library decode_lib;
   use decode_lib.all;
   use decode_lib.decode_pkg.all;

entity decode is
   port (
      signal inst    : in std_logic_vector(31 downto 0);
      signal rd      : out std_logic_vector(4 downto 0);
      signal rs1     : out std_logic_vector(4 downto 0);
      signal rs2     : out std_logic_vector(4 downto 0);
      signal imm_I   : out std_logic_vector(31 downto 0);
      signal imm_S   : out std_logic_vector(31 downto 0);
      signal imm_B   : out std_logic_vector(31 downto 0);
      signal imm_U   : out std_logic_vector(31 downto 0);
      signal imm_J   : out std_logic_vector(31 downto 0);
      signal opcode  : out std_logic_vector(4 downto 0);
      signal func3   : out std_logic_vector(2 downto 0);
      signal func7   : out std_logic_vector(6 downto 0)
   );
end entity decode;

architecture rtl of decode is


begin
   -- R type
   func7    <= inst(31 downto 25);
   rs2      <= inst(24 downto 20);
   rs1      <= inst(19 downto 15);
   func3    <= inst(14 downto 12);
   rd       <= inst(11 downto 7);
   
   opcode <= inst(6 downto 2) when inst(4) = '0' or inst(4) = '1' else
             (others => '0');

   -- I type
   imm_I(10 downto 0)   <= inst(30 downto 20);
   imm_I(31 downto 11)  <= 21x"1fffff" when inst(31) = '1' else 21x"0"; 

   -- S type
   imm_S(10 downto 0)   <= inst(30 downto 25) & inst(11 downto 7);
   imm_S(31 downto 11)  <= 21x"1fffff" when inst(31) = '1' else 21x"0";

   -- B type
   imm_B(11 downto 0)   <= inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0';
   imm_B(31 downto 12)  <= 20x"fffff" when inst(31) = '1' else 20x"00000";

   -- U type
   imm_U <= inst(31 downto 12) & 12x"0";

   -- J type
   imm_J(20 downto 0)   <= inst(31) & inst(19 downto 12) & inst(20) & 
      inst(30 downto 21) & '0';
   imm_J(31 downto 21)  <= 11x"7ff" when inst(31) else 11x"0";

   p_decode : process(all)
   begin
   end process p_decode;

end architecture rtl;
