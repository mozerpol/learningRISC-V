library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library gpio_lib;
   use gpio_lib.all;
   use gpio_lib.gpio_pkg.all;

entity gpio is
   port (
      i_clk    : in std_logic;
      i_addr   : in std_logic_vector(31 downto 0);
      i_wdata  : in std_logic_vector(31 downto 0);
      o_gpio   : out std_logic_vector(3 downto 0)
);
end gpio;

architecture rtl of gpio is


begin

   p_gpio : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_addr = 6d"63") then
            o_gpio <= i_wdata(3 downto 0);
         end if;
      end if;
   end process p_gpio;

end rtl;
