library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library main_lib;
   use main_lib.all;
   use main_lib.main_pkg.all;

entity main is
   port (
      i_rst          : in std_logic;
      i_clk          : in std_logic;
      i_wr_data      : in std_logic_vector(31 downto 0);
      i_wr_enable    : in std_logic;
      o_rd_data      : out std_logic_vector(31 downto 0)
   );
end entity main;

architecture rtl of main is

begin

   p_main : process(all)
   begin
      if (i_rst) then
      -- elsif (clk'event and clk = '1') then
      end if;
   end process p_main;

end architecture rtl;
