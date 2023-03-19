library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity inst_mgmt_tb is
end inst_mgmt_tb;

architecture tb of inst_mgmt_tb is

   component inst_mgmt is
   port (
   );
   end component inst_mgmt;
 
begin

   inst_inst_mgmt : component inst_mgmt 
   port map (
   );

   inst_mgmt_tb : process
   begin

      wait for 25 ns;
      stop(2); 
   end process inst_mgmt_tb;

end architecture tb;
