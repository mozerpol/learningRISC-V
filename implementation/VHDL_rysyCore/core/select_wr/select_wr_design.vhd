library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library select_wr_lib;
   use select_wr_lib.all;
   use select_wr_lib.select_wr_pkg.all;


entity select_wr_design is
   port (
      signal rs2_d      : in std_logic_vector(REG_LEN-1 downto 0);
      signal sel_type   : in std_logic_vector(2 downto 0);
      signal sel_addr   : in std_logic_vector(1 downto 0);
      signal be         : out std_logic_vector(3 downto 0);
      signal wdata      : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity select_wr_design;

architecture rtl of select_wr_design is

begin

   p_select_wr : process(all)
   begin
   end process p_select_wr;

end architecture rtl;
