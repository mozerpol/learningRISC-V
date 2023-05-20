library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity gpio_tb is
end gpio_tb;

architecture tb of gpio_tb is

   component gpio is
   port (
   );
   end component gpio;

begin
   inst_gpio : component gpio 
   port map (
   );

   p_tb : process
   begin
      wait for 25 ns;
      stop(2); 
   end process p_tb;

   p_clock_gen : process
   begin
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
   end process p_clock_gen;

end architecture tb;
