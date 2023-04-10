library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity reg_file_tb is
end reg_file_tb;

architecture tb of reg_file_tb is

   component reg_file_design is
   port (
   );
   end component reg_file_design;
   
begin
   inst_reg_file : component reg_file_design 
   port map (
   );

   p_tb : process
   begin

      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
