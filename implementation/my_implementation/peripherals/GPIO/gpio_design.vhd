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
      i_addr   : in std_logic_vector(5 downto 0);
      i_wdata  : in std_logic_vector(31 downto 0);
      o_gpio   : out std_logic_vector(3 downto 0)
);
end gpio;

architecture rtl of gpio is

begin

   p_gpio : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         -- The last RAM address (63) is mapped to the GPIO output, if necessary, 
         -- get to the GPIO, need to do 63*4 (=255)
         if (i_addr = 6d"63") then
            -- Last 8 bits from wdata vector are mapped
            o_gpio(0) <= i_wdata(24);
            o_gpio(1) <= i_wdata(25);
            o_gpio(2) <= i_wdata(26);
            o_gpio(3) <= i_wdata(27);
            -- o_gpio(4) <= i_wdata(28);
            -- o_gpio(5) <= i_wdata(29);
            -- o_gpio(6) <= i_wdata(30);
            -- o_gpio(7) <= i_wdata(31);
         end if;
      end if;
   end process p_gpio;

end rtl;
