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
      i_rst             : in std_logic
   );
   end component main;

   signal rst_tb           : std_logic;

begin

   inst_main : component main 
   port map (
      i_rst             => rst_tb
   );

   p_tb : process
   begin

      rst_tb            <= '1';
      wait for 20 ns;
      rst_tb            <= '0';

      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
