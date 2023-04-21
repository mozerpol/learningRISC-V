library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;
  
architecture tb of select_rd_tb is

   component select_rd_design is
      port (
      );
   end component select_rd_design;

   
begin
   inst_select_rd : component select_rd_design 
   port map (
   );

end architecture tb;
