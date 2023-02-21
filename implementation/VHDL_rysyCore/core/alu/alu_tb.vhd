library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity alu is
end alu;

architecture tb of alu is

   component alu is
   port (
   );
   end component alu;

begin
   inst_alu : component alu 
   port map (
   );

   p_tb : process
   begin
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
