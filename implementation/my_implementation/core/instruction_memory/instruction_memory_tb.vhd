library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library instruction_memory_lib;
   use instruction_memory_lib.all;
   use instruction_memory_lib.instruction_memory_pkg.all;

entity instruction_memory_tb is
end instruction_memory_tb;

architecture tb of instruction_memory_tb is

   component instruction_memory is
   port (
      i_rst             : in std_logic
   );
   end component instruction_memory;

   signal rst_tb              : std_logic;

begin

   inst_instruction_memory : component instruction_memory
   port map (
      i_rst             => rst_tb
   );

   p_tb : process
   begin

      rst_tb         <= '1';
      wait for 5 ns;
      rst_tb         <= '0';


      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
