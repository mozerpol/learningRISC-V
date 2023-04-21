library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;


entity select_rd_design is
   port (
      signal rdata         : in std_logic_vector(REG_LEN-1 downto 0);
      signal sel_type      : in std_logic_vector(2 downto 0);
      signal sel_addr_old  : in std_logic_vector(1 downto 0);
      signal rd_mem        : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity select_rd_design;

architecture rtl of select_rd_design is

begin

end architecture rtl;
