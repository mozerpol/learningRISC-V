library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity program_counter_tb is
end program_counter_tb;

architecture tb of program_counter_tb is

   component program_counter is
   port (
   );
   end component program_counter;

begin

   inst_program_counter : component program_counter 
   port map (
   );

   p_tb : process
   begin
       
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
