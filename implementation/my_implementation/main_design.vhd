library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library main_lib;
   use main_lib.all;
   use main_lib.main_pkg.all;

entity main is
   port (
      i_rst             : in std_logic
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
