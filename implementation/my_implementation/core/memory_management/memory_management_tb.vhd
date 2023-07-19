library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library memory_management_lib;
   use memory_management_lib.all;
   use memory_management_lib.memory_management_pkg.all;

entity memory_management_tb is
end memory_management_tb;

architecture tb of memory_management_tb is

   component memory_management is
   port (
      i_rst             : in std_logic
   );
   end component memory_management;

   signal rst_tb           : std_logic;

begin

   inst_memory_management : component memory_management 
   port map (
      i_rst             => rst_tb
   );

   p_tb : process
   begin

      
      wait for 25 ns;
      stop(2); 
   end process p_tb;

end architecture tb;
