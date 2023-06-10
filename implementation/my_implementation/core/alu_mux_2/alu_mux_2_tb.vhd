library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity alu_mux_2_tb is
end alu_mux_2_tb;

architecture tb of alu_mux_2_tb is

   component alu_mux_2 is
   port (
   );
   end component alu_mux_2;

begin

   inst_alu_mux_2 : component alu_mux_2 
   port map (
   );

   p_tb : process
   begin
       
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
