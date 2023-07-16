library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity main_tb is
end main_tb;

architecture tb of main_tb is

   component main is
   port (

   );
   end component main;



begin

   inst_main : component main
   port map (

   );


   p_tb : process
   begin
      
      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
