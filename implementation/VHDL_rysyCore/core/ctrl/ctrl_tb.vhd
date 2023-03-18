library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity ctrl_tb is
end ctrl_tb;

architecture tb of ctrl_tb is

   component ctrl is
   port (
   );
   end component ctrl;

 
begin

   inst_ctrl : component ctrl 
   port map (
   );

   ctrl_tb : process
   begin

      wait for 25 ns;
      stop(2); 
   end process ctrl_tb;

end architecture tb;
