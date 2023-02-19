library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity alu2_mux_tb is
end alu2_mux_tb;

architecture tb of alu2_mux_tb is

   component alu2_mux_design is
   port (
   );
   end component alu2_mux_design;

begin
   inst_alu2_mux : component alu2_mux_design 
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
