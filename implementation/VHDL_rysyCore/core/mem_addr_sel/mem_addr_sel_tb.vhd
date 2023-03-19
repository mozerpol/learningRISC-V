library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity mem_addr_sel_tb is
end mem_addr_sel_tb;

architecture tb of mem_addr_sel_tb is

   component mem_addr_sel is
   port (
   );
   end component mem_addr_sel;
 
begin

   inst_mem_addr_sel : component mem_addr_sel 
   port map (
   );

   mem_addr_sel_tb : process
   begin

      wait for 25 ns;
      stop(2); 
   end process mem_addr_sel_tb;

end architecture tb;
