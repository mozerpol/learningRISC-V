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

   p_decode : process(all)
   begin

   end process p_decode;

end architecture rtl;
