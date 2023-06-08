library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity memory_tb is
end memory_tb;

architecture tb of memory_tb is

   component memory is
   port (
   );
   end component memory;

begin

   inst_memory : component memory 
   port map (
   );

   p_tb : process
   begin
       
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
