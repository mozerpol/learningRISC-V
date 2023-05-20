library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity bus_interconnect_tb is
end bus_interconnect_tb;

architecture tb of bus_interconnect_tb is

   component bus_interconnect is
   port (
   );
   end component bus_interconnect;

begin
   inst_bus_interconnect : component bus_interconnect 
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
