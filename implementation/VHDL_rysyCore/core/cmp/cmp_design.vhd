library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library cmp_lib;
   use cmp_lib.all;
   use cmp_lib.cmp_pkg.all;

entity cmp is
   port (
      rs1_d    : in std_logic_vector(REG_LEN-1 downto 0);
      rs2_d    : in std_logic_vector(REG_LEN-1 downto 0);
      cmp_op   : in std_logic_vector(2 downto 0);
      b        : out std_logic
   );
end entity cmp;

architecture rtl of cmp is

   signal rs1_d_s    : std_logic_vector(REG_LEN-1 downto 0);
   signal rs2_d_s    : std_logic_vector(REG_LEN-1 downto 0);
   signal o          : std_logic;

begin

   b        <= o;
   rs1_d_s  <= rs1_d;
   rs2_d_s  <= rs2_d;

   p_cmp : process(all)
   begin
      -- case (cmp_op) is
         --when EQ => o <= (rs1_d == rs2_d);

   end process p_cmp;

end architecture rtl;
