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

begin

   p_cmp : process(all)
   begin
      case (cmp_op) is
         when EQ => b <= '1' when rs1_d = rs2_d else '0';
         when NE => b <= '1' when rs1_d /= rs2_d else '0';
         when LT => b <= '1' when signed(rs1_d) < signed(rs2_d) else '0';
         when GE => b <= '1' when signed(rs1_d) >= signed(rs2_d) else '0';
         when LTU => b <= '1' when unsigned(rs1_d) < unsigned(rs2_d) else '0';
         when GEU => b <= '1' when unsigned(rs1_d) >= unsigned(rs2_d) else '0';
         when others => b <= '0';
      end case;

   end process p_cmp;

end architecture rtl;
