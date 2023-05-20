library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity byte_enabled_simple_dual_port_ramtb is
end byte_enabled_simple_dual_port_ramtb;

architecture tb of byte_enabled_simple_dual_port_ramtb is

   component byte_enabled_simple_dual_port_ram is
   port (
   );
   end component byte_enabled_simple_dual_port_ram;

begin
   inst_bus_interconnect : component byte_enabled_simple_dual_port_ram 
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
