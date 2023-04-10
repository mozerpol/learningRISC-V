library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity rd_mux_tb is
end rd_mux_tb;

architecture tb of rd_mux_tb is

   component rd_mux_design is
   port (
   );
   end component rd_mux_design;

begin
   inst_rd_mux : component rd_mux_design 
   port map (
   );

   p_tb : process
   begin
   
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
